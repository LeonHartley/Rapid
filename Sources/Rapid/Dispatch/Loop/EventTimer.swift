//
// Created by leon on 23/02/17.
//

import Foundation
import Habbo


public class EventTimer {
    private var timer: UnsafeMutablePointer<uv_timer_t>
    private var stopped: Bool = false

    private var context: UnsafeMutablePointer<EventTimerContext>?

    init(timer: UnsafeMutablePointer<uv_timer_t>) {
        self.timer = timer
    }

    deinit {
        if(!self.stopped) {
            self.stop()
        }

        self.context?.deallocate(capacity: 1)
        self.timer.deallocate(capacity: 1)
    }

    public func start(_ startDelayMilliseconds: Int, _ delayMilliseconds: Int, _ block: @escaping () -> ()) {
        if let oldContext = self.context {
            oldContext.deallocate(capacity: 1)
        }

        context = UnsafeMutablePointer<EventTimerContext>.allocate(capacity: 1)
        context?.initialize(to: EventTimerContext(callback: block))

        self.timer.pointee.data = UnsafeMutableRawPointer(context)

        uv_timer_start(self.timer, timerStart, UInt64(startDelayMilliseconds), UInt64(delayMilliseconds))
    }

    public func stop() {
        uv_timer_stop(self.timer)
        self.stopped = true
    }
}

public func timerStart(handle: UnsafeMutablePointer<uv_timer_t>?) {
    if let context = handle?.pointee.data.assumingMemoryBound(to: EventTimerContext.self) {
        context.pointee.callback()
    }
}

public struct EventTimerContext {
    let callback: () -> ()
}