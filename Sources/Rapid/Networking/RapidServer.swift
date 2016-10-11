import Dispatch
import Socket
import LoggerAPI
import KituraNet

class RapidServer {
    private var port: Int?
    private var backlog: Int?

    private var listenerSocket: Socket?
    private var socketManager: IncomingSocketManager?

    init() {} 

    internal func startServer(port: Int, backlog: Int) {
        do {
            self.port = port
            self.backlog = backlog
            
            self.listenerSocket = try Socket.create()
            self.socketManager = IncomingSocketManager()

            ListenerGroup.enqueueAsynchronously(on: DispatchQueue.global(), block: DispatchWorkItem(block: {
                self.listen()
            }))

            ListenerGroup.waitForListeners()
        } catch let error {
             if let socketError = error as? Socket.Error {
                Log.error("Failed to start server socket, error: \n\(socketError.description)")
             } else {
                Log.error("Failed to start server service \(error)")
             }
        }
    }

    private func listen() {
        do {
            try self.listenerSocket?.listen(on: self.port!, maxBacklogSize: self.backlog!)

            Log.info("Listening on port \(self.port!)")

            repeat {
                do {
                    if let clientSocket = try self.listenerSocket?.acceptClientConnection() {
                        Log.info("Accepted connection from: \(clientSocket.remoteHostname):\(clientSocket.remotePort)")
                        self.manageClientConection(socket: clientSocket)
                    }
                } catch {
                    Log.info("Error while accepting single connection")
                }
            } while true
        } catch {
            Log.error("Error thrown while listening on socket")
        }
    }

    private func manageClientConection(socket clientSocket: Socket?) {
        self.socketManager?.handle(socket: clientSocket!, processor: MessageProcessor())
    }
}