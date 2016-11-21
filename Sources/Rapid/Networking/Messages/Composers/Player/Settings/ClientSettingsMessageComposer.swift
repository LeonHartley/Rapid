
class ClientSettingsMessageComposer: MessageComposer {

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(100)
        buffer.writeInt(100)
        buffer.writeInt(100)

        buffer.writeBool(false)
        buffer.writeBool(false)
        buffer.writeBool(false)

        buffer.writeInt(0)
        buffer.writeInt(0)
    }

    func getId() -> Int {
        return Composers.ClientSettingsMessageComposer
    }
}