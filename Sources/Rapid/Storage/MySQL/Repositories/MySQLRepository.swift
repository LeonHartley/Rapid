
class MySQLRepository {
    internal var dataStore: MySQLDataStore

    public init(_ dataStore: MySQLDataStore) {
        self.dataStore = dataStore
    }
}