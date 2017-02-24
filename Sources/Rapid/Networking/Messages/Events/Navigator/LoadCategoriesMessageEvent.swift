//
// Created by root on 24/02/17.
//

import Foundation

class LoadCategoriesMessageEvent: MessageEvent<LoadCategoriesMessageParser> {
    override func handle(_ parser: LoadCategoriesMessageParser) {
        guard let player = self.player else {
            return
        }

        player.getSession().send(RoomCategoriesMessageComposer())
    }

}
