
protocol PlayerRepository {
    func findPlayer(byTicket ticket: String) -> Player?

    func savePlayer(_ player: Player)
}