
protocol RoomModelRepository {
    func findModel(byName name: String) -> RoomModelData?
}
