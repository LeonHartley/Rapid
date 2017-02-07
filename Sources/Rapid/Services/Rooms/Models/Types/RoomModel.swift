
public class RoomModel {

    private(set) public var modelData: RoomModelData

    private var roomMap: [[RoomModelTileState]] = []

    init(modelData: RoomModelData) {
        self.modelData = modelData

        self.generateRoomMap()
    }    

    private func generateRoomMap() {
        let rows = self.modelData.heightmapData.components(separatedBy: "\\n")

        for i in 0...(rows.count - 1) {
            self.roomMap.append([])

            let rowData = rows[i].characters

            for char in rowData {
                if(char == "x") {
                    self.roomMap[i].append(RoomModelTileState.closed)
                } else {
                    self.roomMap[i].append(RoomModelTileState.open)
                }
                
                // default height is is 0, parse the char to an integer to figure out
                // the tile's actual height. (if it's not 0)
                var tileHeight: Double = 0.0
                
            }
        }
    }
}