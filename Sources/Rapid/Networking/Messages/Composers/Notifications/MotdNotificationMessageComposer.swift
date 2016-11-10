
class MotdNotificationMessageComposer: MessageComposer {
    private var message: String 

    init(_ message: String) {
        self.message = message
    }

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(1)
        buffer.writeString(self.message)
    }

    func getId() -> Int {
        return Composers.MotdNotificationMessageComposer
    }
}