
protocol PlayerRepository {
    func findPlayer(byTicket ticket: String) -> PlayerModel?

    func savePlayer(_ player: Player)
}