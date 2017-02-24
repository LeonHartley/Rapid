//
// Created by leon on 23/02/17.
//

import Foundation
import Dispatch
import Habbo

/**
 * Event dispatchers are different to the Dispatch-based queues. These are run via internal uv loops.
 * Processing of rooms are run via Libuv-based event loops. :)
 * The provided DispatchQueue is used to execute the eventloop (let libdispatch find us a thread!)
 */
public class EventDispatcher {
    private static let syncDispatcher = DispatchQueue(label: "EventDispatcherSync")
    public static let main = EventDispatcher(queue: DispatchQueue(label: "EventDispatcher", attributes: .concurrent))

    private var eventLoop: UnsafeMutablePointer<uv_loop_t> = UnsafeMutablePointer<uv_loop_t>.allocate(capacity: 1)
    private var queue: DispatchQueue

    public init(queue: DispatchQueue) {
        self.queue = queue

        // todo: create a pool of event loops.
        uv_loop_init(self.eventLoop)

        self.queue.async {
            uv_run(self.eventLoop, UV_RUN_DEFAULT)
        }
    }

    public func createTimer() -> EventTimer {
        let timer = UnsafeMutablePointer<uv_timer_t>.allocate(capacity: 1)
        uv_timer_init(self.eventLoop, timer)

        return EventTimer(timer: timer)
    }
}
