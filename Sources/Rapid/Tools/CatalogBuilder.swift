import Foundation
import LoggerAPI
import XML

/**
 * The purpose of the catalog builder is to parse Habbo Hotel's furnidata and create a sorted catalog (used for debugging.)
 */
public class CatalogBuilder {
    private static var catalogPageCounter = 1

    public static var built: Bool = false

    public static var catalogItems: [Int: CatalogItem] = [:]
    public static var catalogPages: [String: CatalogPage] = [:]

    public static func build() {
        // Parse the XML document

        if let fileContent =  try? String(contentsOfFile: "./Utilities/furnidata.xml", encoding: .utf8)  {
            if let xml = XMLDocument(xmlString: fileContent) {
                // loop through the item types (floor & wall)
                for itemType in xml.rootNode!.children {
                    // individual items
                    for item in itemType.children {
                        let itemId = Int(item["id"]!)!
                        let furnitureCategory = item.firstChildWithName("furniline")!.value!

                        // Create the catalog item & item definition
                        addCatalogPage(name: furnitureCategory, catalogItemId: itemId)
                        addCatalogItem(name: furnitureCategory, itemId: itemId)
                    }
                }
            }
        }

        built = true
    }

    private static func addCatalogPage(name: String, catalogItemId: Int) {
        if let catalogPage = catalogPages[name] {
            catalogPage.addItem(catalogItemId: catalogItemId)
        } else {
            let catalogPage = createCatalogPage(name: name)
            catalogPage.addItem(catalogItemId: catalogItemId)

            catalogPages[name] = catalogPage
        }
    }

    private static func addCatalogItem(name: String, itemId: Int) {
        let catalogItem = createCatalogItem(name: name, itemId: itemId)

        catalogItems[itemId] = catalogItem
    }

    private static func createCatalogPage(name: String) -> CatalogPage {
        let catalogPage = CatalogPage(id: catalogPageCounter,
                name: name,
                template: "default_3x3",
                type: .normal,
                icon: 2,
                enabled: true,
                images: [],
                texts: ["Click on an item for more information"],
                data: [:])

        catalogPageCounter = catalogPageCounter + 1
        return catalogPage
    }

    private static func createCatalogItem(name: String, itemId: Int) -> CatalogItem {
        let catalogItem = CatalogItem(id: itemId,
            itemName: name,
            itemId: itemId,
            costCredits: 5,
            costActivityPoints: 0,
            costPremiumPoints: 0,
            purchaseType: .item,
            purchaseData: "",
            giftAvailable: true,
            discountAvailable: false)

        return catalogItem
    }
}
