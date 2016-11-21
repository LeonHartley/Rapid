
class FuserightsMessageComposer: MessageComposer {

    private var rank: Int

    public init(forRank rank: Int) {
        self.rank = rank
    }    

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(2) //hc level
        buffer.writeInt(self.rank) // rank
        buffer.writeBool(false) // can do something?
    }

    func getId() -> Int {
        return Composers.FuserightsMessageComposer
    }
}