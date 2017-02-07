
public class EntityComponent {
    private var room: Room?
    
    private var entityIdCounter: Int = 0
    private var entities: [Int: Entity] = [:]

    public func initialise(room: Room) {
        self.room = room
    }

    public func addEntity(entity: Entity) {
        self.room?.syncDispatcher.sync {
            self.entityIdCounter += 1

            entity.id = self.entityIdCounter
            self.entities[entity.id] = entity
        }
    }

    public var playerCount: Int {
        get {
            // todo: only count the players.
            return self.entities.count
        }
    }

    public func dispose() {

    }
}