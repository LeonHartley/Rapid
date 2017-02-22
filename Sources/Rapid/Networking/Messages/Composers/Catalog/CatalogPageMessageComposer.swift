//
// Created by leon on 21/02/17.
//

import Foundation

class CatalogPageMessageComposer: MessageComposer {
    private var page: CatalogPage

    public init(page: CatalogPage) {
        self.page = page
    }

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(self.page.id)
        buffer.writeString("NORMAL")
        buffer.writeString(self.page.template)
        buffer.writeInt(self.page.images.count)

        for image in self.page.images {
            buffer.writeString(image)
        }

        buffer.writeInt(self.page.texts.count)

        for text in self.page.texts {
            buffer.writeString(text)
        }

        buffer.writeInt(page.items.count)

        for itemId in page.items {
            guard let catalogItem = Rapid.catalogService.catalogItems[itemId] else {
                break // d/c the client
            }

            buffer.writeInt(catalogItem.id)
            buffer.writeString(catalogItem.itemName)
            buffer.writeBool(false)//??
            buffer.writeInt(catalogItem.costCredits)
            buffer.writeInt(0)//currencystuff
            buffer.writeInt(0)//currencystuff

            buffer.writeBool(catalogItem.giftAvailable)

            buffer.writeInt(1)//offer count

            buffer.writeString("s")
            buffer.writeInt(catalogItem.itemId)

            buffer.writeString(catalogItem.purchaseData)
            buffer.writeInt(1)//amount
            buffer.writeBool(false)//limited edition

            buffer.writeInt(0)//club level
            buffer.writeBool(catalogItem.discountAvailable)
            buffer.writeBool(false)//??
            buffer.writeString("")//??
        }

        buffer.writeBool(false); // allow seasonal currency as credits
    }

    func getId() -> Int {
        return Composers.CatalogPageMessageComposer
    }
}