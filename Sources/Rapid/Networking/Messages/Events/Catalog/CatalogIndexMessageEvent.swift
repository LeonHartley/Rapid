//
// Created by leon on 21/02/17.
//

import Foundation

class CatalogIndexMessageEvent: MessageEvent<CatalogIndexMessageParser> {
    override func handle(_ parser: CatalogIndexMessageParser) {
        guard let player = self.player else {
            return
        }

        player.getSession().send(CatalogIndexMessageComposer())
    }
}
