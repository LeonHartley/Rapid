import Foundation
import Dispatch

class SessionStore {
    private static let sessionStore: SessionStore = SessionStore()

    private var sessions: [UUID: Session] = [:]

    public func addSession(_ session: Session) {
        DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in 
            self.sessions[session.sessionId()] = session
        }
    }

    public func removeSession(_ session: Session) {
        DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in 
            self.sessions.removeValue(forKey: session.sessionId())
        }
    }

    public func sessionCount() -> Int? {
        return DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in 
            self.sessions.count
        }
    }

    public func getSession(_ sessionId: UUID) -> Session? {
        return DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in 
            self.sessions[sessionId]
        }
    }

    public func broadcastAsync(_ composer: MessageComposer) {
        var sessions: [Session] = []

        defer {
            sessions.removeAll()
        }

        DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in 
            sessions.append(contentsOf: Array(self.sessions.values))
        }

        DispatchQueue.sessionDispatcher.async { [unowned self] in
            for session in sessions {
                session.send(composer)
            }
        }
    }

    public static func getInstance() -> SessionStore {
        return sessionStore
    }
}