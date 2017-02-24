//
// Created by leon on 24/02/17.
//

import Foundation

public enum RoomMuteState: Int{
    case none = 0
    case rights = 1

    public static func muteState(forString str: String) -> RoomMuteState {
        switch str {
        case "none":
            return .none
        case "rights":
            return .rights
        default:
            return .none
        }
    }
}
