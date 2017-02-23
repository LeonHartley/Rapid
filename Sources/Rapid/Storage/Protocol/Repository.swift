//
// Created by leon on 22/02/17.
//

import Foundation

class Repository<T: DataStore>  {
    internal var dataStore: T

    public init(dataStore: T) {
        self.dataStore = dataStore
    }
}
