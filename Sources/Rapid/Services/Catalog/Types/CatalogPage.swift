import Foundation

public class CatalogPage {
    private(set) public var id: Int
    private(set) public var name: String
    private(set) public var template: String
    private(set) public var type: CatalogPageType
    private(set) public var icon: Int
    private(set) public var enabled: Bool

    private(set) public var images: [String]
    private(set) public var texts: [String]

    private(set) public var data: [String: String]

    private(set) public var items: [Int]

    public init(id: Int, name: String, template: String, type: CatalogPageType, icon: Int, enabled: Bool, images: [String],
                texts: [String], data: [String: String]) {
        self.id = id
        self.name = name
        self.template = template
        self.type = type
        self.icon = icon
        self.enabled = enabled
        self.images = images
        self.texts = texts
        self.data = data
        self.items = []
    }

    public func addItem(catalogItemId: Int) {
        self.items.append(catalogItemId)
    }
}
