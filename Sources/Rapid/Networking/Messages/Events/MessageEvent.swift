import Foundation
import Dispatch

import LoggerAPI

protocol BufferProcessor {
    func process(session: Session, buffer: MessageBuffer)
}

class MessageEvent<T: MessageParser>: BufferProcessor {

    internal var session: Session?
    internal var player: Player?

    internal var playerService: PlayerService?
    internal var parser: T?

    init() {
        
    }

    func process(session: Session, buffer: MessageBuffer) {
        // set message-scope variables
        self.session = session
        self.playerService = Rapid.playerService

        if let player = session.player {
            self.player = player
        }

        if(self.player == nil && self.requiresPlayer()) {
            return
        }

        self.parser = T(buffer)

        let currentTimestamp = Date().timeIntervalSince1970 * 1000

        session.eventQueue().async { [unowned self] in
            self.handle(self.parser!)

            let timeDifference = (Date().timeIntervalSince1970 * 1000) - currentTimestamp

            Log.verbose("Handled message \(String(describing: type(of: self))) in \(timeDifference)ms")

            // unset them
            self.session = nil
            self.player = nil
            self.playerService = nil
        }
    }

    func requiresPlayer() -> Bool {
        return true
    }

    func handle(_ parser: T) {
        Log.error("Event handler not fully implemented")
    }
}