import Foundation
import Dispatch

extension Rapid {
    public static let sessionStore: SessionStore = SessionStore()
}

public class SessionStore {
    private var sessions: [UUID: Session] = [:]

    private func disposeSession(_ session: Session) {
        session.removePlayer()
    }

    public func addSession(_ session: Session) {
        let _ = DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in 
            self.sessions[session.sessionId()] = session
        }
    }

    public func removeSession(forSession session: Session) {
        self.disposeSession(session)

        let _ = DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in 
            self.sessions.removeValue(forKey: session.sessionId())
        }
    }

    public func removeSession(forId id: UUID) {
        if let session = self.getSession(id) { 
            self.disposeSession(session)
        }

        let _ = DispatchQueue.sessionSyncDispatcher.sync { [unowned self] in 
            self.sessions.removeValue(forKey: id)
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
        DispatchQueue.sessionSyncDispatcher.async { [unowned self] in
            for session in self.sessions.values {
                session.send(composer)
            }
        }
    }
}