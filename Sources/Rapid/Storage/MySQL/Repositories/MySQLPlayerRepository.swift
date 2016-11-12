import Foundation
import Dispatch
import LoggerAPI

class MySQLPlayerRepository: MySQLRepository, PlayerRepository {
    private var playerSaveQueue: [Int: Player] = [:]

    public override func initialise() {
        self.registerSaveQueueDispatcher()
    }

    private func registerSaveQueueDispatcher() {
        DispatchQueue.playerSaveDispatcher.asyncAfter(everyInterval: 5) { [unowned self] in
            self.flushPlayerQueue()
        }
    }

    private func flushPlayerQueue() {
        let queueSize = self.playerSaveQueue.count

        guard queueSize != 0 else {
            return
        }

        defer {
            // TODO: Check to see if they've been saved
            playerSaveQueue.removeAll()
        }

        do {
            Log.verbose("Flushing player data to database")

            let status = try dataStore.getPool().transaction { conn in
                for (id, player) in playerSaveQueue {
                    Log.verbose("Saving player \(player.id)")
                    try conn.query("UPDATE players SET ? WHERE id = ?", [player as! MySQLPlayer, id])
                }
            }

            Log.verbose("Saved \(queueSize) players from the queue")
        } catch {
            print("Error saving player queue, error \(error)")
        }
    }

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

    public func savePlayer(_ player: Player) {
        DispatchQueue.playerSaveDispatcher.sync { [unowned self] in
            self.playerSaveQueue[player.id] = player
        }
    }
}