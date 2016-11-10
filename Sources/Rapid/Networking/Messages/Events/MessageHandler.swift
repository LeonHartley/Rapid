import LoggerAPI

class MessageHandler {
    private var events: [Int16: BufferProcessor] = [:]

    private var session: Session

    public init(session: Session) {
        self.session = session
    }

    public func registerMessage(id: Int, _ event: BufferProcessor) {
        self.events[Int16(id)] = event

        Log.debug("Registered message handler for id \(id)")
    }

    public func handleMessage(id: Int16, buffer: MessageBuffer) {
        if let event = events[id] {
            event.process(session: session, buffer: buffer)
        }
    }
}