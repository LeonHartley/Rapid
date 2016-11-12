import Foundation

import LoggerAPI

protocol BufferProcessor {
    func process(session: Session, buffer: MessageBuffer)
}

class MessageEvent<T: MessageParser>: BufferProcessor {

    internal var session: Session?

    internal var playerService: PlayerService?

    init() {
        
    }

    func process(session: Session, buffer: MessageBuffer) {
        // set message-scope variables
        self.session = session
        self.playerService = Rapid.playerService

        let parser = T(buffer)

        let currentTimestamp = Date().timeIntervalSince1970 * 1000

        self.handle(parser)

        let timeDifference = (Date().timeIntervalSince1970 * 1000) - currentTimestamp
        Log.verbose("Handled message \(String(describing: type(of: self))) in \(timeDifference)ms")

        // unset them
        self.session = nil
        self.playerService = nil
    }

    func handle(_ parser: T) {
        Log.error("Event handler not fully implemented")
    }
}