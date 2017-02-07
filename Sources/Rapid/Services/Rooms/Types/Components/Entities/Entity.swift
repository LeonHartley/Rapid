
public class Entity {
    public var id: Int
    public var position: Position
    public var room: Room

    public init(id: Int, position: Position, room: Room) {
        self.id = id
        self.position = position
        self.room = room
    }
}