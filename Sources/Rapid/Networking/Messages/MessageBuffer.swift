import Foundation
import Habbo

class MessageBuffer {
    private var buffer: UnsafeMutablePointer<hh_buffer_t>

    init(buffer: UnsafeMutablePointer<hh_buffer_t>) {
        self.buffer = buffer
    }

    deinit {
        hh_buffer_free(self.buffer)
    }

    public func readString() -> String {
        if let string = hh_buffer_read_string(buffer) {
            defer {
                free(string)
            }

            return String(cString: string)
        } else {
            return "";
        }
    }

    public func writeString(_ str: String) {
        str.withCString { cstr in
            hh_buffer_write_string(UnsafeMutablePointer(mutating: cstr), buffer)
        }
    }

    public func reset() {
        hh_buffer_reset(self.buffer)
    }
}