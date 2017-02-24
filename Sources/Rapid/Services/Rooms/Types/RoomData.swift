
public class RoomData {
    private(set) public var id: Int
    private(set) public var name: String
    private(set) public var description: String
    private(set) public var groupId: Int
    private(set) public var ownerId: Int
    private(set) public var ownerName: String

    private(set) public var tags: [String]
    private(set) public var accessType: RoomAccessType
    private(set) public var password: String
    private(set) public var categoryId: Int
    private(set) public var maxPlayers: Int

    private(set) public var allowPets: Bool
    private(set) public var allowEntityWalkThrough: Bool
    private(set) public var banState: RoomBanState
    private(set) public var muteState: RoomMuteState
    private(set) public var kickState: RoomKickState

    public init(id: Int, name: String, description: String, groupId: Int, ownerId: Int, ownerName: String,
                tags: [String], accessType: RoomAccessType, password: String, categoryId: Int, maxPlayers: Int,
                allowPets: Bool, allowEntityWalkThrough: Bool, banState: RoomBanState, muteState: RoomMuteState,
                kickState: RoomKickState) {
        self.id = id
        self.name = name
        self.description = description
        self.groupId = groupId
        self.ownerId = ownerId
        self.ownerName = ownerName
        self.tags = tags
        self.accessType = accessType
        self.password = password
        self.categoryId = categoryId
        self.maxPlayers = maxPlayers
        self.allowPets = allowPets
        self.allowEntityWalkThrough = allowEntityWalkThrough
        self.banState = banState
        self.muteState = muteState
        self.kickState = kickState
    }
}