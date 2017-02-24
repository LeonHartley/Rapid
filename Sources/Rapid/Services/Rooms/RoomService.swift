import Dispatch 
import LoggerAPI

extension Rapid {
    public static let roomService: RoomService = RoomService()
}

extension EventDispatcher {
    public static let roomDispatcher = EventDispatcher(queue: DispatchQueue.roomDispatcher)
}

public class RoomService {
    private var roomProcessingTimer: EventTimer?
    private var loadedRooms: [Int: Room] = [:]

    init() {

    }

    public func initialise() {
        self.roomProcessingTimer = EventDispatcher.roomDispatcher.createTimer()
        self.roomProcessingTimer?.start(500, 500, self.processRooms)

        Log.info("RoomService initialised")
    }

    public func loadRoom(byId id: Int) {
        guard let roomData = DataStore.roomRepository?.findRoom(byId: id) else {
            // Room doesn't exist.
            return
        }

        guard let roomModel = Rapid.roomModelService.findModel(byName: "model_a") else {
            return
        }

        let room = Room(roomData: roomData, roomModel: roomModel)
        
        DispatchQueue.roomSyncDispatcher.sync { 
            self.loadedRooms[room.data.id] = room

            Log.info("Room \(id), \(room.data.name) loaded successfully")
        }
    }

    private func processRooms() {
        var disposedRooms: [Room] = []

        DispatchQueue.roomSyncDispatcher.sync { 
            for (id, room) in self.loadedRooms {
                if (room.playerCount == 0) {
                    room.incrementIdle()
                } else {
                    room.resetIdle()
                }

                if(room.idle || room.unloadRequested) {
                    self.loadedRooms[id] = nil

                    disposedRooms.append(room)
                }
            }
        }

        for room in disposedRooms {
            room.dispose()

            Log.info("Room \(room.data.id), \(room.data.name) disposed successfully")
        }
    }

    deinit {
        self.roomProcessingTimer?.stop()
    }
}
