import Foundation
import Dispatch
import LoggerAPI

class RedbirdPlayerRepository: RedbirdRepository, PlayerRepository {

    public override func initialise() {

    }

    public func findPlayer(byTicket ticket: String) -> PlayerData? {
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

            let playerData = PlayerData(
                id: Int(playerId)!,
                username: playerObject["username"]!,
                figure: playerObject["figure"]!,
                motto: playerObject["motto"]!,
                credits: Int(playerObject["credits"]!)!,
                gender: playerObject["gender"]!.lowercased() == "m" ? .male : .female
            )

            return playerData
        }

        return nil
    }

    public func savePlayer(_ playerData: PlayerData) {
        if let transaction = self.dataStore.createTransaction() {
            defer {
                self.dataStore.closeTransaction(transaction)
            }

            let playerObject = [
                "username": playerData.username,
                "figure": playerData.figure,
                "motto": playerData.motto,
                "credits": "\(playerData.credits)",
                "gender": playerData.gender == .male ? "m" : "f"
            ]

            transaction.storeObject(
                key: "rapid.players:\(playerData.id)",
                object: playerObject)
        }
    }
}
