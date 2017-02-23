import LoggerAPI

class RedbirdRepository: Repository<RedbirdDataStore> {
    public init(_ dataStore: RedbirdDataStore) {
        super.init(dataStore: dataStore)
        self.initialise()

        Log.info("Initialised \(String(describing: type(of: self))) repository")
    }

    public func initialise() {

    }
}   