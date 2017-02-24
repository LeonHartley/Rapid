//
// Created by leon on 24/02/17.
//

import Foundation

protocol PermissionRepository {
    func findPerks() -> [PerkPermission]
}
