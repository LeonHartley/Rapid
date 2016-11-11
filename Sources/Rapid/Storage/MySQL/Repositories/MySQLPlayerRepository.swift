
import LoggerAPI

class MySQLPlayerRepository: MySQLRepository, PlayerRepository {
    public func findPlayer(byTicket ticket: String) -> Player? {
        do {
            let rows: [MySQLPlayer] = try dataStore.getPool().execute { conn in 
                try conn.query("SELECT id, username, figure, motto, credits, gender FROM players WHERE auth_ticket = ?;", [ticket])
            }

            if let player = rows.first {
                return player
            }
        } catch {
            print("Error finding player by sso ticket: \(ticket), error: \(error)")
        }

        return nil
    }
}