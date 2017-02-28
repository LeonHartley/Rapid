//
// Created by leon on 24/02/17.
//

import Foundation
import Dispatch
import LoggerAPI

extension Rapid {
    public static let permissionService = PermissionService()
}

public class PermissionService {

    private var perkPermissionsList: [PerkPermission] = []

    public init() {

    }

    public var perkPermissions: [PerkPermission] {
        get {
            var perkPermissions: [PerkPermission] = []

            DispatchQueue.permissionSyncDispatcher.sync {
                perkPermissions.append(contentsOf: self.perkPermissionsList)
            }

            return perkPermissions
        }
    }

    public func initialise() {
        if let perkPermissions = DataStore.permissionRepository?.findPerks() {
            self.initialise(perkPermissions: perkPermissions)
        }

        Log.info("Loaded \(self.perkPermissions.count) perk permissions")
    }

    public func initialise(perkPermissions: [PerkPermission]) {
        DispatchQueue.permissionSyncDispatcher.sync {
            self.perkPermissionsList.removeAll()
            self.perkPermissionsList = perkPermissions
        }
    }
}
