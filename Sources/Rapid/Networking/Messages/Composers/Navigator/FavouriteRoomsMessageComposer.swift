
class FavouriteRoomsMessageComposer: MessageComposer {
    private static let maxFavouriteRooms = 30

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(FavouriteRoomsMessageComposer.maxFavouriteRooms)
        buffer.writeInt(0)//size of my favourite rooms
    }

    func getId() -> Int {
        return Composers.FavouriteRoomsMessageComposer
    }
}