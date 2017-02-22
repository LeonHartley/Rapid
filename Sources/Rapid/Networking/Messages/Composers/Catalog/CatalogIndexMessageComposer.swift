//
// Created by leon on 21/02/17.
//

import Foundation

class CatalogIndexMessageComposer: MessageComposer {
    func compose(_ buffer: MessageBuffer) {

        buffer.writeBool(true)
        buffer.writeInt(0)
        buffer.writeInt(-1)
        buffer.writeString("root")
        buffer.writeString("")
        buffer.writeInt(0)
        buffer.writeInt(1)

        buffer.writeBool(true)
        buffer.writeInt(0)
        buffer.writeInt(-1)
        buffer.writeString("undefined")
        buffer.writeString("Furniture")
        buffer.writeInt(0)
        buffer.writeInt(Rapid.catalogService.catalogPages.count)//child pages

        for (id, page) in Rapid.catalogService.catalogPages {
            buffer.writeBool(true)
            buffer.writeInt(page.icon)
            buffer.writeInt(page.enabled ? id : -1)
            buffer.writeString("undefined")
            buffer.writeString(page.name)
            buffer.writeInt(0)
            buffer.writeInt(0)//child pages
        }

        buffer.writeBool(true)
        buffer.writeString("NORMAL")
    }

    func getId() -> Int {
        return Composers.CatalogIndexMessageComposer
    }
}