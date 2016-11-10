
import LoggerAPI

protocol MessageParserProtocol {
    init(_ buffer: MessageBuffer) 
}

class MessageParser: MessageParserProtocol {
    required init(_ buffer: MessageBuffer) {
        
    }
}