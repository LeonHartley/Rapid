import Foundation

public protocol MessageComposer {
    func compose(_ buffer: MessageBuffer)

    func getId() -> Int
}
