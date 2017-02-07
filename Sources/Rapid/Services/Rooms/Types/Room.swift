import Dispatch

public class Room {
    private(set) public var syncDispatcher: DispatchQueue 

    private(set) public var data: RoomData
    private(set) public var model: RoomModel

    private(set) public var unloadRequested: Bool = false
    private var unloaded: Bool = false

    private var idleTicks: Int = 0

    // Components
    private(set) public var entityComponent: EntityComponent = EntityComponent()

    init(roomData: RoomData, roomModel: RoomModel) {
        self.data = roomData
        self.model = roomModel

        self.syncDispatcher = DispatchQueue(label: "RoomSyncDispatcher-\(roomData.id)")

        self.initialise()
    }

    public func initialise() {
        self.entityComponent.initialise(room: self)
    }

    public func requestDispose() {
        self.unloadRequested = true
    }

    public func dispose() {
        if(!self.unloadRequested || self.unloaded) {
            return
        }

        self.entityComponent.dispose()

        self.unloaded = true
    }

    public var idle: Bool {
        get {
            // 2400 = 20 minutes - make this configurable..
            return self.idleTicks >= 50
        }
    }

    public func incrementIdle() {
        self.idleTicks += 1
    }

    public func resetIdle() {
        self.idleTicks = 0
    }

    public var playerCount: Int {
        get {
            return entityComponent.playerCount
        }
    }
}