import Foundation

import Dispatch
import LoggerAPI

extension Rapid {
    public static let playerService = PlayerService()
}

class PlayerService {
    private let playerIdToSessionId: [Int:UUID] = [:]
    
    public func authenticatePlayer(byTicket ticket: String, _ session: Session) {
        DispatchQueue.playerDispatcher.async { [unowned self] in
            if let player = DataStore.playerRepository?.findPlayer(byTicket: ticket) {
                session.send(AuthenticationOKMessageComposer())
                session.send(MotdNotificationMessageComposer("hiya, \(player.username)! :D"))

                session.player = player
                session.player?.username = "Leon2"

                if let player = session.player {
                    DataStore.playerRepository?.savePlayer(player)
                }
            } else {
                session.close()
            }
        }
    }
}