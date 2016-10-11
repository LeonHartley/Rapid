import KituraNet
import Foundation

class Session {
    private var processor: MessageProcessor 
    private var sessionId: UUID

    init(processor: MessageProcessor) {
        self.sessionId = UUID()
        self.processor = processor
    }

    public func write(_ data: String) {
        self.processor.write(from: data.data(using: .utf8)! as NSData)
    }

    public func getProcessor() -> MessageProcessor {
        return self.processor
    }

    public func getSessionId() -> UUID {
        return self.sessionId
    }
}