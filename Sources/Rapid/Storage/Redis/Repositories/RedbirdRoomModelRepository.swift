import Foundation

class RedbirdRoomModelRepository: RedbirdRepository, RoomModelRepository {

    public override func initialise() {

    }

    public func findModel(byName name: String) -> RoomModelData? {
        if let transaction = self.dataStore.createTransaction() {
            defer {
                self.dataStore.closeTransaction(transaction)
            }

            guard let roomModelObject = transaction.object(forKey: "rapid.models:\(name)") else {
                return nil
            }

            let roomModelData = RoomModelData(
                name: name,
                doorX: Int(roomModelObject["doorX"]!)!,
                doorY: Int(roomModelObject["doorY"]!)!,
                doorZ: Double(roomModelObject["doorZ"]!)!,
                doorDirection: Int(roomModelObject["doorDirection"]!)!,
                heightmapData: roomModelObject["heightmap"]!
            )

            return roomModelData
        }

        return nil
    }
}