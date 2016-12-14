
protocol PlayerRepository {
    func findPlayer(byTicket ticket: String) -> PlayerData?

    func savePlayer(_ player: PlayerData)
}
