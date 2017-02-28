//
// Created by leon on 28/02/17.
//

import Foundation

class NavigatorSearch {
    private let searchHandlers: [NavigatorCategoryType: NavigatorSearchHandler] = [
        .category: CategorySearchHandler()
    ]

    public init() {

    }

    // TODO: Make this async or not?
    public func search(category: NavigatorCategory, player: Player, expanded: Bool) -> [RoomData] {
        guard let searchHandler = self.searchHandlers[category.category] else {
            return []
        }

        return searchHandler.search(category: category, player: player, expanded: expanded)
    }
}
