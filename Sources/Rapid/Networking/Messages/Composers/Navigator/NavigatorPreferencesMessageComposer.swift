
class NavigatorPreferencesMessageComposer: MessageComposer {
    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(68)//x
        buffer.writeInt(42)//y
        buffer.writeInt(425)//width
        buffer.writeInt(592)//height
        buffer.writeBool(false)//show saved searches
        buffer.writeInt(0)//??
    }

    func getId() -> Int {
        return Composers.NavigatorPreferencesMessageComposer
    }
}