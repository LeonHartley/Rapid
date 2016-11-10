import Foundation
import Dispatch

class SessionStore {
    private static let sessionStore: SessionStore = SessionStore()

    private var sessions: [UUID: Session] = [:]

    public func addSession(_ session: Session) {
        DispatchQueue.sessionDispatcher.sync { [unowned self] in 
            self.sessions[session.getSessionId()] = session
        }
    }

    public func removeSession(_ session: Session) {
        DispatchQueue.sessionDispatcher.sync { [unowned self] in 
            self.sessions.removeValue(forKey: session.getSessionId())
        }
    }

    public func sessionCount() -> Int? {
        return DispatchQueue.sessionDispatcher.sync { [unowned self] in 
            self.sessions.count
        }
    }

    public func getSession(_ sessionId: UUID) -> Session? {
        return DispatchQueue.sessionDispatcher.sync { [unowned self] in 
            self.sessions[sessionId]
        }
    }

    public func broadcastAsync() {
        DispatchQueue.sessionDispatcher.async { [unowned self] in 
            for (id, session) in self.sessions {
                // write to the session
            }
        }
    }

    public static func getInstance() -> SessionStore {
        return sessionStore
    }
}