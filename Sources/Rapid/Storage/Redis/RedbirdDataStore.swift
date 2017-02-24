import Dispatch
import Redbird
import LoggerAPI

class RedbirdDataStore: DataStore {

    private let syncDispatcher = DispatchQueue(label: "RedbirdDataStoreSyncDispatcher")
    private var redisConfiguration: RedbirdConfig

    private var redbirdInstances: [Redbird] = []

    public override init() {
        let config = Configuration.getConfig()

        let host = config["datastore"]["redis"].getString(forKey: "host")
        let port = config["datastore"]["redis"].getInt(forKey: "port")

        self.redisConfiguration = RedbirdConfig(address: host, port: UInt16(port))
    }

    override func configure() {
        let connectionPoolSize = Configuration.getConfig()["datastore"]["redis"].getInt(forKey: "connectionPool")

        Log.info("Starting redbird datastore")

        for connectionId in 1...connectionPoolSize {
            Log.info("Starting redbird connection #\(connectionId)")

            if let connection = self.createConnection() {
                self.returnConnection(connection)
            }
        }

        DataStore.playerRepository = RedbirdPlayerRepository(self)
        DataStore.roomModelRepository = RedbirdRoomModelRepository(self)
        DataStore.roomRepository = RedbirdRoomRepository(self)
        DataStore.permissionRepository = RedbirdPermissionRepository(self)

        super.configure()
    }

    private func createConnection() -> Redbird? {
        var connection: Redbird?

        do {
            connection = try Redbird(config: self.redisConfiguration)
        } catch {
            Log.error("Failed to initialise Redis connection \(error)")
        }

        return connection
    }

    public func createTransaction() -> RedbirdTransaction? {
        guard let connection = self.getConnection() else {
            return nil
        }

        return RedbirdTransaction(connection)
    }

    public func closeTransaction(_ transaction: RedbirdTransaction) {
        self.returnConnection(transaction.client())
    }

    public func getConnection() -> Redbird? {
        var redbird: Redbird?

        self.syncDispatcher.sync { [unowned self] in
            if(self.redbirdInstances.count != 0) {
                let connection = self.redbirdInstances.first
                self.redbirdInstances.removeFirst()

                redbird = connection
            } else {
                redbird = self.createConnection()
            }
        }

        return redbird
    }

    public func returnConnection(_ connection: Redbird) {
        self.syncDispatcher.sync { [unowned self] in
            self.redbirdInstances.append(connection)
        }
    }
}