
extension MessageHandler {
    func registerHandshakeEvents() {
        self.registerMessage(id: Events.SSOTicketMessageEvent, SSOTicketMessageEvent())
        self.registerMessage(id: Events.CheckReleaseMessageEvent, CheckReleaseMessageEvent())
    }
}