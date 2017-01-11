
public class RoomModelData {
    private(set) public var name: String
    private(set) public var doorX: Int
    private(set) public var doorY: Int
    private(set) public var doorZ: Double
    private(set) public var doorDirection: Int
    private(set) public var heightmapData: String

    public init(name: String, doorX: Int, doorY: Int, doorZ: Double, doorDirection: Int, heightmapData: String) {
        self.name = name
        self.doorX = doorX
        self.doorY = doorY
        self.doorZ = doorZ
        self.doorDirection = doorDirection
        self.heightmapData = heightmapData
    }
}