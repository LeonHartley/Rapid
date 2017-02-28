//
// Created by leon on 24/02/17.
//

import Foundation

struct NavigatorCategory {
    public var id: Int
    public var category: NavigatorCategoryType
    public var categoryId: String
    public var publicName: String
    public var canDoActions: Bool
    public var colour: Int
    public var requiredRank: Int
    public var viewMode: NavigatorViewMode
    public var searchAllowance: NavigatorSearchAllowance
    public var visible: Bool
    public var roomCount: Int
    public var roomCountExpanded: Int
}
