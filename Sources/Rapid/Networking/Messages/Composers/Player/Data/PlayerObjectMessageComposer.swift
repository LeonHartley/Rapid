
class PlayerObjectMessageComposer: MessageComposer {

    private var player: PlayerData

    init(playerData: PlayerData) {
        self.player = playerData
    }

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(self.player.id)
        buffer.writeString(self.player.username)
        buffer.writeString(self.player.figure)
        buffer.writeString(self.player.gender.rawValue)
        buffer.writeString(self.player.motto)
        buffer.writeString(self.player.username.lowercased())

        buffer.writeBool(true)
        buffer.writeInt(8)

        buffer.writeInt(3)//respects
        buffer.writeInt(3)//scratches

        buffer.writeBool(true)
        buffer.writeString("")

        buffer.writeBool(false)//canchangeusername
        buffer.writeBool(false)//??
    }

    func getId() -> Int {
        return Composers.PlayerObjectMessageComposer
    }
}