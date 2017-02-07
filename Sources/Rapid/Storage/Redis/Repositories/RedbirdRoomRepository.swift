
class RedbirdRoomRepository: RedbirdRepository, RoomRepository {

    func createRoom(roomData: RoomData) {

    }

    func findRoom(byId id: Int) -> RoomData? {
        // if let transaction = self.dataStore.createTransaction() {
        //     defer {
        //         self.dataStore.closeTransaction(transaction)
        //     }

        //     guard let roomModelObject = transaction.object(forKey: "rapid.room:\(id)") else {
        //         return nil
        //     }

        //     // let roomData = RoomData(
        //     //     id: id,
        //     //     doorX: Int(roomModelObject["doorX"]!)!,
        //     //     doorY: Int(roomModelObject["doorY"]!)!,
        //     //     doorZ: Double(roomModelObject["doorZ"]!)!,
        //     //     doorDirection: Int(roomModelObject["doorDirection"]!)!,
        //     //     heightmapData: roomModelObject["heightmap"]!
        //     // )

        //     return nil
        // }

        return nil
    }   
}