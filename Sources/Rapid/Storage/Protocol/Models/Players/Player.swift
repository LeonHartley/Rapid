
enum Gender: String {
    case male = "M"
    case female = "F"
}

protocol Player {
    var id: Int { get }
    var username: String { get set }
    var figure: String { get set }
    var motto: String { get set }
    var credits: Int { get set }
    var gender: String { get set }
}