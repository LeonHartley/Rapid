import LoggerAPI

class SSOTicketMessageEvent: MessageEvent<SSOTicketMessageParser> {
    override func handle(_ parser: SSOTicketMessageParser) {
        Log.debug("received sso ticket \(parser.authenticationTicket)")

        guard let session = self.session else {
            return
        }

        self.playerService?.authenticatePlayer(byTicket: parser.authenticationTicket, session)
    }

    override func requiresPlayer() -> Bool {
        return false
    }
}