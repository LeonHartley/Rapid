import Foundation
import Habbo
import LoggerAPI

class Session {
    private var sessionId: UUID

    private var messageHandler: MessageHandler?
    private var client: UnsafeMutablePointer<uv_stream_t>

    init(sessionId: UUID, client: UnsafeMutablePointer<uv_stream_t>) {
        self.sessionId = sessionId
        self.client = client
    }

    public func send(_ composer: MessageComposer) {
        let buffer = MessageBuffer(hh_buffer_create_empty(1024))

        buffer.initialise()

        buffer.writeShort(composer.getId())
        composer.compose(buffer)

        hh_write_message(buffer.getBuffer(), self.client)
        Log.info("Sending message with index \(buffer.getIndex())")
        Log.info("Sending message with id \(composer.getId())")
    }

    public func getMessageHandler() -> MessageHandler {
        if let messageHandler = self.messageHandler {
            return messageHandler
        } else {
            let handler = MessageHandler(session: self)
            self.messageHandler = handler

            return handler
        }
    }

    public func getSessionId() -> UUID {
        return self.sessionId
    }
}