
protocol CatalogPage {
    var id: Int { get }
    
    var parentId: Int { get }

    var type: String { get }

    var caption: String { get }

    var icon: Int { get }

    var minimumRank: Int { get }

    var template: String { get }

    var linkName: String { get }

    var enabled: Bool { get }

    var images: String { get }
    
    var texts: String { get }
}