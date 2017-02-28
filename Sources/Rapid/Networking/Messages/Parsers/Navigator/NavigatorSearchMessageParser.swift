//
// Created by leon on 28/02/17.
//

import Foundation

class NavigatorSearchMessageParser: MessageParser {
    public var category: String
    public var data: String

    required init(_ buffer: MessageBuffer) {
        self.category = buffer.readString()
        self.data = buffer.readString()

        super.init(buffer)
    }
}