
class CheckReleaseMessageParser: MessageParser {
    public var clientRelease: String

    required init(_ buffer: MessageBuffer) {
        self.clientRelease = buffer.readString()

        super.init(buffer)
    }
}