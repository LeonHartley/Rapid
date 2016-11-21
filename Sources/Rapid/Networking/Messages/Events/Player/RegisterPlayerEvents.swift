
extension MessageHandler {
    func registerPlayerEvents() {
        self.registerMessage(id: Events.PlayerDataMessageEvent, PlayerDataMessageEvent())
    }
}