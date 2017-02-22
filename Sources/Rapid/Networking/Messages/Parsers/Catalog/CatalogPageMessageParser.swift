//
// Created by leon on 21/02/17.
//

import Foundation

class CatalogPageMessageParser: MessageParser {
    public var pageId: Int

    required init(_ buffer: MessageBuffer) {
        self.pageId = buffer.readInt()

        super.init(buffer)
    }
}