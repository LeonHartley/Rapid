
class HomeRoomMessageComposer: MessageComposer {
    private var homeRoom: Int 

    init(roomId: Int) {
        self.homeRoom = roomId
    }

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(self.homeRoom)
        buffer.writeInt(self.homeRoom)
    }

    func getId() -> Int {
        return Composers.HomeRoomMessageComposer
    }
}