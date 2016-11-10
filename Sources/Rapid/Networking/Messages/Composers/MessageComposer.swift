import Foundation

protocol MessageComposer {
    func compose(_ buffer: MessageBuffer)

    func getId() -> Int
}
