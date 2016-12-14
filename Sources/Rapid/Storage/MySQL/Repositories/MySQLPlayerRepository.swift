import Foundation
import Dispatch
import LoggerAPI

class MySQLPlayerRepository: MySQLRepository, PlayerRepository {
    private var playerSaveQueue: [Int: MySQLPlayerModel] = [:]

    public override func initialise() {
        self.registerSaveQueueDispatcher()
    }

    private func registerSaveQueueDispatcher() {
        //let _ = DispatchQueue.playerSaveDispatcher.asyncAfter(everyInterval: 5) { [unowned self] in
        //    self.flushPlayerQueue()
        //}
    }

    private func flushPlayerQueue() {
        let queueSize = self.playerSaveQueue.count

        guard queueSize != 0 else {
            return
        }

        defer {
            playerSaveQueue.removeAll()
        }

        do {
            Log.verbose("Flushing player data to database")

            try dataStore.getPool().transaction { conn in
                for (id, player) in playerSaveQueue {
                    Log.verbose("Saving player \(player.id)")
                    let _ = try conn.query("UPDATE players SET ? WHERE id = ?", [player as MySQLPlayerModel, id])
                }
            }

            Log.verbose("Saved \(queueSize) players from the queue")
        } catch {
            print("Error saving player queue, error \(error)"   )
        }
    }

    public func findPlayer(byTicket ticket: String) -> PlayerData? {
        do {
            let rows: [MySQLPlayerModel] = try dataStore.getPool().execute { conn in
                try conn.query("SELECT id, username, figure, motto, credits, gender FROM players WHERE auth_ticket = ?;", [ticket])
            }

            if let player = rows.first {
                return PlayerData(
                    id: player.id,
                    username: player.username,
                    figure: player.figure,
                    motto: player.motto,
                    credits: player.credits,
                    gender: player.gender.lowercased() == "m" ? .male : .female
                )
            }
        } catch {
            print("Error finding player by sso ticket: \(ticket), error: \(error)")
        }

        return nil
    }

    public func savePlayer(_ player: PlayerData) {
        // create a model object and store it
        DispatchQueue.playerSaveDispatcher.sync {
            // let
            //self.playerSaveQueue[player.id] = player
        }
    }
}
