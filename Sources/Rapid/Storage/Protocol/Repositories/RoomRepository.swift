
protocol RoomRepository {
    func createRoom(roomData: RoomData)

    func findRoom(byId id: Int) -> RoomData?
}