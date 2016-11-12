import LoggerAPI

class MySQLRepository {
    internal var dataStore: MySQLDataStore

    public init(_ dataStore: MySQLDataStore) {
        self.dataStore = dataStore

        self.initialise()
        Log.info("Initialised \(String(describing: type(of: self))) repository")
    }

    public func initialise() {

    }
}