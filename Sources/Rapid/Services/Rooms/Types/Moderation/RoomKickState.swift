//
// Created by leon on 24/02/17.
//

import Foundation

public enum RoomKickState: Int {
    case everyone = 2
    case rights = 1
    case none = 0

    public static func kickState(forString str: String) -> RoomKickState {
        switch str {
        case "none":
            return .none
        case "rights":
            return .rights
        case "everyone":
            return .everyone
        default:
            return .none
        }
    }
}
