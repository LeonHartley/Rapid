import Foundation
import Habbo
import LoggerAPI

class Session {
    private var sessionIdentifier: UUID

    private var msgHandler: MessageHandler?
    private var client: UnsafeMutablePointer<uv_stream_t>

    public var player: Player?

    init(sessionId: UUID, client: UnsafeMutablePointer<uv_stream_t>) {
        self.sessionIdentifier = sessionId
        self.client = client
    }

    public func send(_ composer: MessageComposer) {
        let buffer = MessageBuffer(hh_buffer_create_empty(1024))

        buffer.initialise()

        buffer.writeShort(composer.getId())
        composer.compose(buffer)

        hh_write_message(buffer.getBuffer(), self.client)
    }

    public func close() {
        // remove the session from any rooms or whatever here.
        hh_close_session(self.client)
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
}