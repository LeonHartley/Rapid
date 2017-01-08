import Habbo 

class HHServerConfig {
    public let configPointer: UnsafeMutablePointer<hh_server_config_t> = UnsafeMutablePointer<hh_server_config_t>.allocate(capacity: 1)

    public var onConnection: hh_connection_cb {
        set(cb) { 
            self.configPointer.pointee.on_connection = cb
        }

        get {
            return self.configPointer.pointee.on_connection
        }
    }

   public var onConnectionClosed: hh_disconnection_cb {
        set(cb) { 
            self.configPointer.pointee.on_connection_closed = cb
        }

        get {
            return self.configPointer.pointee.on_connection_closed
        }
    }

    public var onMessageReceived: hh_receive_message_cb {
        set(cb) { 
            self.configPointer.pointee.on_message = cb
        }

        get {
            return self.configPointer.pointee.on_message
        }   
    }

    deinit {
        configPointer.deallocate(capacity: 1)
    }
}