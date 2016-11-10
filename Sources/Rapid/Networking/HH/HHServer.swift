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

    init(host: String, port: Int) {
        let config = HHServerConfig()

        config.onConnection = { client in
            if let clientId = hh_client_id(client) {

                if let uuid = UUID(uuidString: String(cString: clientId)) {
                    let session = Session(sessionId: uuid, client: client!)
                    SessionStore.getInstance().addSession(session)

                    session.getMessageHandler().registerHandshakeEvents()

                    Log.info("Registered session with id \(uuid.uuidString)")
                }
            }
        }

        config.onConnectionClosed = { client in
            if let clientId = hh_client_id(client) {
                Log.info("Session disconnected with id \(String(cString: clientId))")
            }
        }

        config.onMessageReceived = { client, message in
            DispatchQueue.messageDispatcher.async {
                if let clientId = hh_client_id(client) {
                    if let uuid = UUID(uuidString: String(cString: clientId)) {
                        if let session = SessionStore.getInstance().getSession(uuid) {
                            let buffer = MessageBuffer(message!)

                            let messageLength = buffer.readInt()
                            let messageId = buffer.readShort()

                            session.getMessageHandler().handleMessage(id: messageId, buffer: buffer)
                        
                            buffer.freeBuffer()
                        }
                    }
                } 
            }
        }

        host.withCString { hostStr in
            hh_start_server(UnsafeMutablePointer(mutating: hostStr), Int32(port), config.configPointer)
        }
    }
}