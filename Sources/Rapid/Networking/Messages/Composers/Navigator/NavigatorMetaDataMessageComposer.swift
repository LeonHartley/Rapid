//
// Created by leon on 24/02/17.
//

import Foundation

class NavigatorMetaDataMessageComposer: MessageComposer {
    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(4)

        buffer.writeString("official_view")
        buffer.writeInt(0)

        buffer.writeString("hotel_view")
        buffer.writeInt(0)

        buffer.writeString("roomads_view")
        buffer.writeInt(0)

        buffer.writeString("myworld_view")
        buffer.writeInt(0)
    }

    func getId() -> Int {
        return Composers.NavigatorMetaDataMessageComposer
    }
}