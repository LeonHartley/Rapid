
protocol PlayerRepository {
    func findPlayer(byTicket ticket: String) -> Player?
}