import Foundation

public class CatalogItem {

    private(set) public var id: Int
    private(set) public var itemName: String
    private(set) public var itemId: Int

    private(set) public var costCredits: Int
    private(set) public var costActivityPoints: Int
    private(set) public var costPremiumPoints: Int

    private(set) public var purchaseType: CatalogPurchaseType
    private(set) public var purchaseData: String

    private(set) public var giftAvailable: Bool
    private(set) public var discountAvailable: Bool

    public init(id: Int, itemName: String, itemId: Int, costCredits: Int,
                costActivityPoints: Int, costPremiumPoints: Int, purchaseType: CatalogPurchaseType,
                purchaseData: String, giftAvailable: Bool, discountAvailable: Bool) {
        self.id = id
        self.itemName = itemName
        self.itemId = itemId
        self.costCredits = costCredits
        self.costActivityPoints = costActivityPoints
        self.costPremiumPoints = costPremiumPoints
        self.purchaseType = purchaseType
        self.purchaseData = purchaseData
        self.giftAvailable = giftAvailable
        self.discountAvailable = discountAvailable
    }
}
