
class AvailabilityStatusMessageComposer: MessageComposer {
    func compose(_ buffer: MessageBuffer) {
        buffer.writeBool(false)
        buffer.writeBool(false)
        buffer.writeBool(true)
    }

    func getId() -> Int {
        return Composers.AvailabilityStatusMessageComposer
    }
}