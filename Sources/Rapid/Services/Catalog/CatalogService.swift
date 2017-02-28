//
// Created by leon on 20/02/17.
//

import Dispatch
import Foundation
import LoggerAPI

extension Rapid {
    public static let catalogService = CatalogService()
}

public class CatalogService {

    private var catalogPagesMap: [Int: CatalogPage] = [:]
    private var catalogItemsMap: [Int: CatalogItem] = [:]

    public init() {

    }

    public var catalogPages: [Int: CatalogPage] {
        get {
            var catalogPages: [Int: CatalogPage] = [:]

            DispatchQueue.catalogSyncDispatcher.sync {
                for (id, catalogPage) in self.catalogPagesMap{
                    catalogPages[id] = catalogPage
                }
            }

            return catalogPages
        }
    }

    public var catalogItems: [Int: CatalogItem] {
        get {
            var catalogItems: [Int: CatalogItem] = [:]

            DispatchQueue.catalogSyncDispatcher.sync {
                for (id, catalogItem) in self.catalogItemsMap {
                    catalogItems[id] = catalogItem
                }
            }

            return catalogItems
        }
    }

    public func initialise() {
        if(CatalogBuilder.built) {
            // Using generated catalog
            self.initialise(items: CatalogBuilder.catalogItems)
            self.initialise(pages: CatalogBuilder.catalogPages)
        } else {
            // No generated catalog, load one from the datastore or xml file elsewhere.
        }

        Log.info("Loaded \(self.catalogItems.count) catalog items and \(self.catalogPages.count) catalog pages")
    }

    private func initialise(pages: [String: CatalogPage]) {
        DispatchQueue.catalogSyncDispatcher.sync {
            self.catalogPagesMap.removeAll()

            for (_, page) in pages {
                self.catalogPagesMap[page.id] = page
            }
       }
    }

    private func initialise(pages: [Int: CatalogPage]) {
        DispatchQueue.catalogSyncDispatcher.sync {
            self.catalogPagesMap.removeAll()
            self.catalogPagesMap = pages
        }
    }

    private func initialise(items: [Int: CatalogItem]) {
        DispatchQueue.catalogSyncDispatcher.sync {
            self.catalogItemsMap.removeAll()
            self.catalogItemsMap = items
        }
    }
}
