import MySQL

class MySQLDataStore: DataStore {
    private let connectionPool: ConnectionPool = ConnectionPool(options: DataStoreConfiguration())

    override func configure() {
        DataStore.playerRepository = MySQLPlayerRepository(self)
    }

    func getPool() -> ConnectionPool {
        return self.connectionPool
    }
}