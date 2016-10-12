import Foundation
import KituraNet
import LoggerAPI

class MessageProcessor: IncomingSocketProcessor {
    /// A back reference to the `IncomingSocketHandler` processing the socket that
    /// this `IncomingDataProcessor` is processing.
    public weak var handler: IncomingSocketHandler?

    /// Keep alive timeout for idle sockets in seconds
    static let keepAliveTimeout: TimeInterval = 60

    /// A flag indicating that the client has requested that the socket be kept alive
    private(set) var clientRequestedKeepAlive = false

    /// The socket if idle will be kep alive until...
    public var keepAliveUntil: TimeInterval = 0.0

    /// A flag that indicates that there is a request in progress
    public var inProgress = true

    /// The number of remaining requests that will be allowed on the socket being handled by this handler
    private(set) var numberOfRequests = 100

    /// Should this socket actually be kept alive?
    var isKeepAlive: Bool {
        return clientRequestedKeepAlive && numberOfRequests > 0
    }

    /// An enum for internal state
    enum State {
        case reset, initial, messageCompletelyRead
    }

    /// The state of this handler
    private(set) var state = State.initial

    public var session: Session?

    public func process(_ buffer: NSData) -> Bool {
        let result: Bool

        switch (state) {
        case .reset:
            state = .initial
            fallthrough

        case .initial:
            inProgress = true
            parse(buffer)
            result = true

        case .messageCompletelyRead:
            result = false
        }

        return result
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
                self.session!.write("DAQBHHIIKHJIPAIQAdd-MM-yyyy\0SAHPB/client\0QBH\0")
            }
        }
    }

    func errorString(error: Int32) -> String {
        return "error: \(error)"
        //return String(validatingUTF8: strerror(error)) ?? "Error: \(error)"
    }
}