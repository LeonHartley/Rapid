//
// Created by leon on 24/02/17.
//

import Foundation

class RoomCategoriesMessageComposer: MessageComposer {
    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(0)
    }

    func getId() -> Int {
        return Composers.RoomCategoriesMessageComposer
    }
}
