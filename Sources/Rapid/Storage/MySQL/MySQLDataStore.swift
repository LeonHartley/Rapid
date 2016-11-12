import MySQL
import LoggerAPI

class MySQLDataStore: DataStore {
    private let connectionPool: ConnectionPool = ConnectionPool(options: DataStoreConfiguration())

    override func configure() {
        Log.info("Initialising MySQLDataStore repositories")

        DataStore.playerRepository = MySQLPlayerRepository(self)
    }

    func getPool() -> ConnectionPool {
        return self.connectionPool
    }
}