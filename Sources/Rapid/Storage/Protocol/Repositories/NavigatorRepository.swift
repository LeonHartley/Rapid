//
// Created by leon on 28/02/17.
//

import Foundation

protocol NavigatorRepository {
    func findCategories() -> [Int: NavigatorCategory]
}
