#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import Habbo
import Dispatch
import Foundation
import LoggerAPI

class HHServer {
    let config = HHServerConfig()

    init() {
        config.onConnection = { client in
            if let clientId = hh_client_id(client) {

                if let uuid = UUID(uuidString: String(cString: clientId)) {
                    let session = Session(sessionId: uuid, client: client!)
                    Rapid.sessionStore.addSession(session)

                    Log.debug("Registered session with id \(uuid.uuidString)")
                }
            }
        }

        config.onConnectionClosed = { client in
            if let clientId = hh_client_id(client) {
                if let uuid = UUID(uuidString: String(cString: clientId)) {
                    Rapid.sessionStore.removeSession(forId: uuid)

                    Log.debug("Removed session with id \(uuid.uuidString)")
                }
            }
        }

        config.onMessageReceived = { client, message in
            guard let clientId = hh_client_id(client) else {
                return
            }

            guard let uuid = UUID(uuidString: String(cString: clientId)) else {
                return
            }

            if let session = Rapid.sessionStore.getSession(uuid) {
                let buffer = MessageBuffer(message!)

                //msg length
                let _ = buffer.readInt()

                // todo: if we don't have a full buffer, wait until we do and retry.
                let messageId = buffer.readShort()

                session.messageHandler().handleMessage(id: messageId, buffer: buffer)

                buffer.freeBuffer()
            }
        }

        hh_initialise_config(self.config.configPointer)
    }

    public func initialise(host: String, port: Int) {
        DispatchQueue.networkingDispatcher.async {
          host.withCString { hostStr in
              hh_start_server(UnsafeMutablePointer(mutating: hostStr), Int32(port))
          }
        }
    }
}
