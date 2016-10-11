import Foundation

class SessionManager {
    private static var sessionManager: SessionManager = SessionManager()

    private var sessions: [UUID: Session] = [:]

    public func addSession(_ session: Session) {
        self.sessions[session.getSessionId()] = session
    }

    public func removeSession(_ session: Session) {
        self.sessions.removeValue(forKey: session.getSessionId())
    }

    public func getSessions() -> [Session] {
        return Array(self.sessions.values)
    }

    public static func getInstance() -> SessionManager {
        return sessionManager
    }
}