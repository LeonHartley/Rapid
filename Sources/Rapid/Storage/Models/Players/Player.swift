
import MySQL

struct Player: QueryRowResultType {
    let id: Int
    let username: String
    let figure: String
    let motto: String
    let credits: Int
    let gender: Gender

    enum Gender: String, SQLEnumType {
        case male = "M"
        case female = "F"
    }
    
    static func decodeRow(r: QueryRowResult) throws -> Player {
        return try Player(
            id: r <| "id",
            username: r <| "username",
            figure: r <| "figure",
            motto: r <| "motto",
            credits: r <| "credits",
            gender: r <| "gender"
        )
    }
}