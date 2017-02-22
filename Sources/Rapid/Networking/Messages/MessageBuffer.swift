import Foundation
import Habbo

public class MessageBuffer {
    private var buffer: UnsafeMutablePointer<hh_buffer_t>

    init(_ buffer: UnsafeMutablePointer<hh_buffer_t>) {
        self.buffer = buffer
    }

    public func readString() -> String {
        if let string = hh_buffer_read_string(buffer) {
            defer {
                free(string)
            }

            return String(cString: string)
        } else {
            return ""
        }
    }

    public func writeShort(_ short: Int) {
        hh_buffer_write_short(Int16(short), buffer)
    }

    public func readInt() -> Int {
        let i = hh_buffer_read_int(buffer)
        
        return Int(i)
    }

    public func writeInt(_ i: Int) {
        hh_buffer_write_int(Int32(i), buffer)
    }

    public func writeBool(_ b: Bool) {
        hh_buffer_write_bool(Int32(b ? 1 : 0), buffer)
    }


    public func readShort() -> Int16 {
        return hh_buffer_read_short(buffer)
    }

    public func writeString(_ str: String) {
        hh_buffer_write_string(UnsafeMutablePointer(mutating: str), buffer)
    }

    public func initialise() {
        hh_buffer_initialise(self.buffer)
    }

    public func reset() {
        hh_buffer_reset(self.buffer)
    }
    
    public func prepare() {
        hh_buffer_prepare(self.buffer)
    }

    public func freeBuffer() {
        hh_buffer_free(self.buffer)
    }

    public func getIndex() -> Int{
        return Int(self.buffer.pointee.index)
    }

    public func getBuffer() -> UnsafeMutablePointer<hh_buffer_t> {
        return self.buffer
    }
}