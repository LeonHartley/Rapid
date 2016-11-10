
class SSOTicketMessageParser: MessageParser {
    public var authenticationTicket: String

    required init(_ buffer: MessageBuffer) {
        self.authenticationTicket = buffer.readString()

        super.init(buffer)
    }
}