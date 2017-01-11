import Dispatch 

extension Rapid {
    public static let roomModelService: RoomModelService = RoomModelService()
}

public class RoomModelService {
    private let syncDispatcher = DispatchQueue(label: "RoomModelServiceSyncDispatcher")
    
    private var roomModels: [String: RoomModel] = [:]

    public func findModel(byName name: String) -> RoomModel? {
        if let cachedModel = self.getModel(key: name) {
            return cachedModel
        }

        if let model = DataStore.roomModelRepository?.findModel(byName: name) {
            let modelObj = RoomModel(modelData: model)

            self.addModel(key: name, model: modelObj)

            return modelObj
        }

        return nil
    }

    private func getModel(key: String) -> RoomModel? {
        return self.syncDispatcher.sync { [unowned self] in
            self.roomModels[key]
        }
    }

    private func addModel(key: String, model: RoomModel) {
        self.syncDispatcher.sync { [unowned self] in
            self.roomModels[key] = model
        }
    }

}
