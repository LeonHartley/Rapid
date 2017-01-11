import Foundation

import Dispatch
import LoggerAPI

extension Rapid {
    public static let playerService = PlayerService()
}

class PlayerService {
    private var playerIdToSessionId: [Int: UUID] = [:]
    private var playerUsernameToPlayerId: [String: Int] = [:]

    public func authenticatePlayer(byTicket ticket: String, _ session: Session) {
        if let playerData = DataStore.playerRepository?.findPlayer(byTicket: ticket) {

            session.send(AuthenticationOKMessageComposer())
            session.send(AvailabilityStatusMessageComposer())
            session.send(FavouriteRoomsMessageComposer())
            session.send(FuserightsMessageComposer(forRank: 7))
            session.send(ClientSettingsMessageComposer())
            session.send(HomeRoomMessageComposer(roomId: 0))

            session.send(MotdNotificationMessageComposer("hiya, \(playerData.username)! :D"))

            // todo: allow the ability to send a list of messages and use 1 single buffer
            let player = Player(session: session, playerData: playerData)

            DataStore.playerRepository?.savePlayer(playerData)

            //cache player stuff.
            self.addPlayer(player)
            session.addPlayer(player)
        } else {
            session.close()
        }
    }

    public func addPlayer(_ player: Player) {
        DispatchQueue.playerSyncDispatcher.sync { [unowned self] in
            self.playerIdToSessionId[player.getData().id] = player.getSession().sessionId()
            self.playerUsernameToPlayerId[player.getData().username] = player.getData().id
        }
    }

    public func removePlayer(_ player: Player) {
        DispatchQueue.playerSyncDispatcher.sync { [unowned self] in
            self.playerIdToSessionId.removeValue(forKey: player.getData().id)
            self.playerUsernameToPlayerId.removeValue(forKey: player.getData().username)
        }
    }

    public func playerCount() -> Int {
        var count = 0

        DispatchQueue.playerSyncDispatcher.sync { [unowned self] in
            count = self.playerIdToSessionId.count
        }

        return count
    }
}
