
enum Gender: String {
    case male = "M"
    case female = "F"
}

struct PlayerData {
    var id: Int
    var username: String
    var figure: String 
    var motto: String
    var credits: Int
    var gender: Gender
}