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
    var isKeepAlive: Bool { return clientRequestedKeepAlive && numberOfRequests > 0 }
    
    /// An enum for internal state
    enum State {
        case reset, initial, messageCompletelyRead
    }
        /// The state of this handler
    private(set) var state = State.initial
    
    init() { }

    public func process(_ buffer: NSData) -> Bool {
        let result: Bool

        switch(state) {
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
        //handler?.write(from: data)
    }

    public func write(from bytes: UnsafeRawPointer, length: Int) {
        //handler?.write(from: bytes, length: length)
    }
    
    public func close() {
        //handler?.prepareToClose()
        //request.release()
    }
    
    private func parse(_ buffer: NSData) {
        let str = String(data: buffer as Data, encoding: .utf8)

        Log.info("Message received: \(str!)")
    }
    
    private func parsingComplete() {
        //state = .messageCompletelyRead
        //response.reset()

        /*DispatchQueue.global().async() { [unowned self] in
            self.delegate?.handle(request: self.request, response: self.response)
        }*/
    }
    
    func keepAlive() {
        /*state = .reset
        numberOfRequests -= 1
        inProgress = false
        keepAliveUntil = Date(timeIntervalSinceNow: IncomingHTTPSocketProcessor.keepAliveTimeout).timeIntervalSinceReferenceDate
        handler?.handleBufferedReadData()*/
    }
    
    func errorString(error: Int32) -> String {
        return "error: \(error)"
        //return String(validatingUTF8: strerror(error)) ?? "Error: \(error)"
    }
}