import MySQL
import LoggerAPI

class DataStore {
    private static let dataStore: DataStore = DataStore()

    private let connectionPool: ConnectionPool = ConnectionPool(options: DataStoreConfiguration())

    init() {
        DataStore.playerRepository.initialise(self)
    }

    func getPool() -> ConnectionPool {
        return self.connectionPool
    }

    public static func getInstance() -> DataStore {
        return dataStore
    }
}