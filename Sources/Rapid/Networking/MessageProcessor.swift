/*import Foundation
import KituraNet
import LoggerAPI
import Habbo

class MessageProcessor: IncomingSocketProcessor {
    public weak var handler: IncomingSocketHandler?
    public var keepAliveUntil: TimeInterval = 0.0
    public var inProgress = true

    public var session: Session?

    public func process(_ buffer: NSData) -> Bool {
        parse(buffer)
        return true
    }

    public func write(from data: NSData) {
        handler?.write(from: data)
    }

    public func write(from bytes: UnsafeRawPointer, length: Int) {
        handler?.write(from: bytes, length: length)
    }

    public func close() {
        SessionManager.getInstance().removeSession(self.session!)

        handler?.prepareToClose()
    }

    private func parse(_ buffer: NSData) {
        if let data = String(data: buffer as Data, encoding: .utf8) {
            print("reading buffer with length: \(buffer.length) and data is \(data)")

            if (data.characters.first! == "<") {
                // policy
                print("sending policy")
                self.session!.write("<?xml version=\"1.0\"?>\r\n<!DOCTYPE cross-domain-policy SYSTEM \"/xml/dtds/cross-domain-policy.dtd\">\r\n<cross-domain-policy>\r\n<allow-access-from domain=\"*\" to-ports=\"*\" />\r\n</cross-domain-policy>\0")
                self.close()
            } else {
                // Create a buffer with the received message data
                data.withCString { dataBuffer in
                    let buffer = MessageBuffer(hh_buffer_create(UnsafeMutablePointer(mutating: dataBuffer), Int32(data.characters.count)))

                    let length = buffer.readInt()
                    let header = buffer.readShort()

                    print("game packet received \(header)")
                }
            }
        }
    }

    public func connectionClosed() {
        print("connection closed")
    }
}*/