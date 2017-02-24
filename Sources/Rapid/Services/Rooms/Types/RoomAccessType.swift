
public enum RoomAccessType {
    case open
    case password
    case doorbell

    public static func accessType(forString str: String) -> RoomAccessType {
        switch str {
            case "open": return .open
            case "password": return .password
            case "doorbell": return .doorbell
            default: return .open
        }
    }
}