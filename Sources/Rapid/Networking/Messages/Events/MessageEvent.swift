import LoggerAPI

protocol BufferProcessor {
    func process(session: Session, buffer: MessageBuffer)
}

class MessageEvent<T: MessageParser>: BufferProcessor {

    internal var session: Session?

    init() {
        
    }

    func process(session: Session, buffer: MessageBuffer) {
        self.session = session

        let parser = T(buffer)

        self.handle(parser)

        self.session = nil
    }

    func handle(_ parser: T) {
        Log.error("Event handler not fully implemented")
    }
}