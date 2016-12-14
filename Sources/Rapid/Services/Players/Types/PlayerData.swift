
enum Gender: String {
    case male = "M"
    case female = "F"
}

class PlayerData {
    private(set) public var id: Int
    private(set) public var username: String
    private(set) public var figure: String
    private(set) public var motto: String
    private(set) public var credits: Int
    private(set) public var gender: Gender

    public init(id: Int, username: String, figure: String, motto: String, credits: Int, gender: Gender) {
        self.id = id
        self.username = username
        self.figure = figure
        self.motto = motto
        self.credits = credits
        self.gender = gender
    }

    public func setUsername(_ username: String) {
        self.username = username
    }

    public func setFigure(_ figure: String) {
        self.figure = figure
    }

    public func setMotto(_ motto: String) {
        self.motto = motto
    }

    public func incrementCredits(byAmount amount: Int) {
        self.credits += amount
    }

    public func decrementCredits(byAmount amount: Int) {
        self.credits -= amount
    }

    public func setGender(_ gender: Gender) {
        self.gender = gender
    }
}
