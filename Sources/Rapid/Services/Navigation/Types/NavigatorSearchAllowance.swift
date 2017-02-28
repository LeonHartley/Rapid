//
// Created by leon on 28/02/17.
//

import Foundation

enum NavigatorSearchAllowance: Int {
    case nothing = 0
    case showMore = 1
    case goBack = 2

    public static func searchAllowance(forInt num: Int) -> NavigatorSearchAllowance {
        switch num {
        case 0: return .nothing
        case 1: return .showMore
        case 2: return .goBack
        default: return .nothing
        }
    }
}
