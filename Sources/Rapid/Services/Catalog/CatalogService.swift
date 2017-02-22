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

    private(set) public var catalogPages: [Int: CatalogPage] = [:]
    private(set) public var catalogItems: [Int: CatalogItem] = [:]

    public init() {

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
            self.catalogPages.removeAll()

            for (_, page) in pages {
                self.catalogPages[page.id] = page
            }
       }
    }

    private func initialise(pages: [Int: CatalogPage]) {
        DispatchQueue.catalogSyncDispatcher.sync {
            self.catalogPages.removeAll()
            self.catalogPages = pages
        }
    }

    private func initialise(items: [Int: CatalogItem]) {
        DispatchQueue.catalogSyncDispatcher.sync {
            self.catalogItems.removeAll()
            self.catalogItems = items
        }
    }
}
