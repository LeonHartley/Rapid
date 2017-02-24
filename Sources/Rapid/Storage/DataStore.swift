import MySQL
import LoggerAPI

class DataStore {
    private static var dataStore: DataStore?

    public static var playerRepository: PlayerRepository?
    public static var roomModelRepository: RoomModelRepository?
    public static var roomRepository: RoomRepository?
    public static var permissionRepository: PermissionRepository?

    public func configure() {

    }

    public static func setInstance(_ dataStore: DataStore) {
        self.dataStore = dataStore
    }

    public static func getInstance() -> DataStore {
        return dataStore ?? DataStore()
    }
}