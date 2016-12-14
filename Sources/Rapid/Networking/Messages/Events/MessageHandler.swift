import Foundation
import LoggerAPI
import Dispatch

class MessageHandler {
    private var events: [Int16: BufferProcessor] = [:]

    private var session: Session

    public init(session: Session) {
        self.session = session

        self.registerMessage(id: Events.SSOTicketMessageEvent, SSOTicketMessageEvent())
        self.registerMessage(id: Events.CheckReleaseMessageEvent, CheckReleaseMessageEvent())
    }

    public func registerMessage(id: Int, _ event: BufferProcessor) {
        DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in
            self.events[Int16(id)] = event
        }

        Log.debug("Registered message handler for id \(id)")
    }

    public func registerEvents() {
        self.registerMessage(id: Events.PlayerDataMessageEvent, PlayerDataMessageEvent())
    }

    public func handleMessage(id: Int16, buffer: MessageBuffer) {
        if let event = findEvent(forId: id) {
            let currentTimestamp = Date().timeIntervalSince1970 * 1000

            event.process(session: session, buffer: buffer)

            let timeDifference = (Date().timeIntervalSince1970 * 1000) - currentTimestamp

            Log.verbose("Handled message \(String(describing: type(of: event))) in \(timeDifference)ms")
        } else {
            Log.verbose("Unhandled message with id #\(id)")
        }
    }

    public func findEvent(forId id: Int16) -> BufferProcessor?  {
        return DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in
            self.events[id]
        }
    }
}
