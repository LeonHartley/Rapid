import Foundation
import LoggerAPI
import Dispatch

public class MessageHandler {
    private var events: [Int16: BufferProcessor] = [:]

    private var session: Session

    public init(session: Session) {
        self.session = session

        self.registerMessage(id: Events.SSOTicketMessageEvent, SSOTicketMessageEvent())
        self.registerMessage(id: Events.CheckReleaseMessageEvent, CheckReleaseMessageEvent())
        self.registerMessage(id: Events.PlayerDataMessageEvent, PlayerDataMessageEvent())

        // Catalog
        self.registerMessage(id: Events.CatalogIndexMessageEvent, CatalogIndexMessageEvent())
        self.registerMessage(id: Events.CatalogPageMessageEvent, CatalogPageMessageEvent())
    }

    public func registerMessage(id: Int, _ event: BufferProcessor) {
        DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in
            self.events[Int16(id)] = event
        }

        Log.debug("Registered message handler for id \(id)")
    }

    public func registerEvents() {
        
    }

    public func handleMessage(id: Int16, buffer: MessageBuffer) {
        if let event = findEvent(forId: id) {
            event.process(session: session, buffer: buffer)
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
