
class Repository {
    internal var dataStore: DataStore?

    public func initialise(_ dataStore: DataStore) {
        self.dataStore = dataStore
    }
}