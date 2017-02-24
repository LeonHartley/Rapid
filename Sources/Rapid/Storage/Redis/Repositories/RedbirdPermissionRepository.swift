//
// Created by leon on 24/02/17.
//

import Foundation

class RedbirdPermissionRepository: RedbirdRepository, PermissionRepository {
    func findPerks() -> [PerkPermission] {
        return [PerkPermission(title: "NAVIGATOR_PHASE_TWO_2014", data: "", overrideRank: true, overrideDefault: true, minRank: 1)]
    }
}
