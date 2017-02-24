
class RedbirdRoomRepository: RedbirdRepository, RoomRepository {

    func createRoom(roomData: RoomData) {

    }

    func findRoom(byId id: Int) -> RoomData? {
         if let transaction = self.dataStore.createTransaction() {
             defer {
                 self.dataStore.closeTransaction(transaction)
             }

             guard let roomDataObject = transaction.object(forKey: "rapid.rooms:\(id)") else {
                 return nil
             }

             let roomObject = RoomData(id: id,
                     name: roomDataObject["name"] ?? "Unknown",
                     description: roomDataObject["description"] ?? "",
                     groupId: Int(roomDataObject["groupId"] ?? "0") ?? 0,
                     ownerId: Int(roomDataObject["ownerId"] ?? "0") ?? 0,
                     ownerName: roomDataObject["ownerName"] ?? "Unknown",
                     tags: [],
                     accessType: RoomAccessType.accessType(forString: roomDataObject["accessType"] ?? "open"),
                     password: roomDataObject["password"] ?? "",
                     categoryId: Int(roomDataObject["categoryId"] ?? "0") ?? 0,
                     maxPlayers: Int(roomDataObject["maxPlayers"] ?? "10") ?? 10,
                     allowPets: Bool(roomDataObject["allowPets"] ?? "false") ?? false,
                     allowEntityWalkThrough: Bool(roomDataObject["allowEntityWalkThrough"] ?? "false") ?? false,
                     banState: RoomBanState.banState(forString: roomDataObject["banState"] ?? "none"),
                     muteState: RoomMuteState.muteState(forString: roomDataObject["muteState"] ?? "none"),
                     kickState: RoomKickState.kickState(forString: roomDataObject["kickState"] ?? "none"))

             return roomObject
         }

        return nil
    }   
}