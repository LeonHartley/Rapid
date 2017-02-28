//
// Created by leon on 28/02/17.
//

import Foundation

protocol NavigatorSearchHandler {
    func search(category: NavigatorCategory, player: Player, expanded: Bool) -> [RoomData]
}
