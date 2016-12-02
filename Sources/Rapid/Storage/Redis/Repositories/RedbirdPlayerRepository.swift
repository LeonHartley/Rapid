import Foundation
import Dispatch
import LoggerAPI

class RedbirdPlayerRepository: RedbirdRepository, PlayerRepository {

    public override func initialise() {
    }
    
    public func findPlayer(byTicket ticket: String) -> PlayerModel? {
        if let transaction = self.dataStore.createTransaction() {
            defer {
                self.dataStore.closeTransaction(transaction)
            }
            
            guard let playerId = transaction.string(fromMap: "rapid.authTickets", key: ticket) else {
                return nil
            }

            guard let playerObject = transaction.object(forKey: "rapid.players:\(playerId)") else {
                return nil
            }

            let playerModel = RedbirdPlayerModel(
                id: Int(playerId)!,
                username: playerObject["username"]!,
                figure: playerObject["figure"]!,
                motto: playerObject["motto"]!,
                credits: Int(playerObject["credits"]!)!,
                gender: playerObject["gender"]!
            )

            return playerModel
        }

        return nil
    }

    public func savePlayer(_ player: Player) {

    }
}