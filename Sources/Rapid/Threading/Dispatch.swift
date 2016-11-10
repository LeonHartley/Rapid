import Dispatch

extension DispatchQueue {
    /**
     * This is used to keep message handling away from the libuv loop
     */
    public static let messageDispatcher = DispatchQueue(label: "MessageDispatcher", attributes: .concurrent)

    /**
     * This queue is used to keep the session-related stores in sync in a high-concurrency environment
     */
    public static let sessionDispatcher = DispatchQueue(label: "SessionDispatcher")
}