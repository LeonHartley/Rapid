import LoggerAPI

class RedbirdRepository {
    internal var dataStore: RedbirdDataStore

    public init(_ dataStore: RedbirdDataStore) {
        self.dataStore = dataStore

        self.initialise()

        Log.info("Initialised \(String(describing: type(of: self))) repository")
    }

    public func initialise() {

    }
}   