//
// Created by leon on 22/02/17.
//

enum DataStoreType: String {
    case rapid = "rapid"
    case redis = "redis"
    case mongodb = "mongodb"
    case mysql = "mysql"

    public func create() -> DataStore? {
        switch self {
            case .rapid:
                 return nil

            case .redis:
                 return RedbirdDataStore()

            case .mongodb:
                return nil

            case .mysql:
                return MySQLDataStore()
        }
    }
}
