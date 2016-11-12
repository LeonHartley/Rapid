
import MySQL

struct MySQLPlayer: QueryRowResultType, Player, QueryParameterDictionaryType {
    var id: Int
    var username: String
    var figure: String
    var motto: String
    var credits: Int
    var gender: String

    static func decodeRow(r: QueryRowResult) throws -> MySQLPlayer {
        return try MySQLPlayer(
            id: r <| "id",
            username: r <| "username",
            figure: r <| "figure",
            motto: r <| "motto",
            credits: r <| "credits",
            gender: r <| "gender"
        )
    }

    func queryParameter() throws -> QueryDictionary {
        return QueryDictionary([
            "username": username,
            "figure": figure,
            "motto": motto,
            "credits": credits,
            "gender": gender
        ])
    }
}