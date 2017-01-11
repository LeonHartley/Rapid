
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
                var tileHeight: Double = 0.0
                
                if(char == "x") {
                    self.roomMap[i].append(RoomModelTileState.closed)
                } else if(char == "0") {
                    self.roomMap[i].append(RoomModelTileState.open)
                } else {
                    // parse height
                }
            }
        }

        for row in roomMap {
            for tile in row {
                print(tile)
            }
        }
    }
}