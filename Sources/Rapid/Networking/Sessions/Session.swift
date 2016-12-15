import Foundation
import Habbo
import LoggerAPI
import Dispatch

class Session {
    private var sessionIdentifier: UUID

    private var msgHandler: MessageHandler?
    private var client: UnsafeMutablePointer<uv_stream_t>

    public var player: Player?

    private var eventDispatcher: DispatchQueue

    deinit {
        if(self.player != nil) {
            self.player?.onRemove()
        }
    }

    init(sessionId: UUID, client: UnsafeMutablePointer<uv_stream_t>) {
        self.sessionIdentifier = sessionId
        self.client = client
        self.eventDispatcher = DispatchQueue(label: "SessionDispatcher-\(sessionId)")
    }

    public func addPlayer(_ player: Player) {
        self.player = player
    }

    public func removePlayer() {
        guard let player = self.player else {
            return
        }

        player.onRemove()

        Rapid.playerService.removePlayer(player)

        self.player = nil
    }

    public func close() {
        // remove the session from any rooms or whatever here.
        self.removePlayer()

        hh_close_session(self.client)
    }

    public func send(_ composer: MessageComposer) {
        let buffer = MessageBuffer(hh_buffer_create_empty(1024))

        buffer.initialise()

        buffer.writeShort(composer.getId())
        composer.compose(buffer)

        Log.verbose("Composed message \(String(describing: type(of: composer)))")

        hh_write_message(buffer.getBuffer(), self.client)
    }

    public func messageHandler() -> MessageHandler {
        guard let messageHandler = self.msgHandler else {
            let handler = MessageHandler(session: self)
            self.msgHandler = handler

            return handler
        }
        
        return messageHandler
    }

    public func sessionId() -> UUID {
        return self.sessionIdentifier
    }

    public func eventQueue() -> DispatchQueue {
        return self.eventDispatcher
    }
}