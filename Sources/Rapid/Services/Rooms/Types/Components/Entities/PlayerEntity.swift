
public class PlayerEntity: Entity {
    public var player: Player   

    init(id: Int, position: Position, player: Player, room: Room) {
        self.player = player
        
        super.init(id: id, position: position, room: room)
    }
}