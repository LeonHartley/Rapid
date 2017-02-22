//
// Created by leon on 21/02/17.
//

import Foundation

class CatalogPageMessageEvent: MessageEvent<CatalogPageMessageParser> {
    override func handle(_ parser: CatalogPageMessageParser) {
        guard let player = self.player else {
            return
        }

        guard let catalogPage = Rapid.catalogService.catalogPages[parser.pageId] else {
            return
        }

        player.getSession().send(CatalogPageMessageComposer(page: catalogPage))
    }
}
