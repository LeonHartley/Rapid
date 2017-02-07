
public class RoomData {
    private(set) public var id: Int
    private(set) public var name: String
    // private(set) public var description: String
    // private(set) public var groupId: Int
    private(set) public var ownerId: Int
    // private(set) public var tagA: String
    // private(set) public var tagB: String
    // private(set) public var accessType: RoomAccessType
    // private(set) public var password: String
    // private(set) public var categoryId: Int
    // private(set) public var maxPlayers: Int

    public init(id: Int, name: String, ownerId: Int) {
        self.id = id
        self.name = name
        self.ownerId = ownerId
    }
}