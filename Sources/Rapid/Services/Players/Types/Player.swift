import LoggerAPI

public class Player {

    private var session: Session

    private var playerId: Int
    private var data: PlayerData

    public init(session: Session, playerData: PlayerData) {
        self.session = session

        self.playerId = playerData.id
        self.data = playerData

        Log.info("Player \(self.data.username) logged in")
    }

    public func onRemove() {
        Log.info("Player \(self.data.username) logged out")
    }

    public func getSession() -> Session {
        return self.session
    }

    public func getPlayerId() -> Int {
        return self.playerId
    }

    public func getData() -> PlayerData {
        return self.data
    }
}
