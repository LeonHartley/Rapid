import LoggerAPI

class SSOTicketMessageEvent: MessageEvent<SSOTicketMessageParser> {
    override func handle(_ parser: SSOTicketMessageParser) {
        Log.info("received sso ticket \(parser.authenticationTicket)")

        if let player = DataStore.playerRepository?.findPlayer(byTicket: parser.authenticationTicket) {
            self.session?.send(AuthenticationOKMessageComposer())
            self.session?.send(MotdNotificationMessageComposer("hiya, \(player.username)! :D"))
        }
    }
}