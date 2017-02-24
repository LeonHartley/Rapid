//
// Created by root on 24/02/17.
//

import Foundation

class InitNavigatorMessageEvent: MessageEvent<InitNavigatorMessageParser> {
    override func handle(_ parser: InitNavigatorMessageParser) {
        guard let player = self.player else {
            return
        }

        player.getSession().send(NavigatorPreferencesMessageComposer())
        player.getSession().send(NavigatorMetaDataMessageComposer())
    }

}
