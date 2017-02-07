import LoggerAPI

public protocol MessageParserProtocol {
    init(_ buffer: MessageBuffer) 
}

public class MessageParser: MessageParserProtocol {
    public required init(_ buffer: MessageBuffer) {
        
    }
}