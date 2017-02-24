//
// Created by leon on 24/02/17.
//

import Foundation
import LoggerAPI

public class JSONParser {
    private var fullJsonData: [String:[String:Any]]?
    private var object: [String:Any]?

    public init(fromString jsonString: String) {
        if let data = jsonString.data(using: .utf8) {
            self.initialise(data: data)
        }
    }

    public init(fromFile file: String) {
        if let fileContent = try? String(contentsOfFile: file, encoding: .utf8).data(using: .utf8) {
            guard let data = fileContent else {
                return
            }

            self.initialise(data: data)
        }
    }

    public init(object: [String:Any]?) {
        self.object = object
    }

    private func initialise(data: Data) {
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:[String:Any]]

            self.fullJsonData = parsedData
            self.object = [:]
        } catch {
            Log.error("Failed to parser JSON data!")
        }
    }

    public subscript(index: String) -> JSONParser {
        if(self.fullJsonData != nil) {
            return JSONParser(object: self.fullJsonData![index])
        }

        return JSONParser(object: self.object![index] as? [String:Any])
    }

    public func keys() -> [String] {
        guard let object = self.object else {
            return []
        }

        return Array(object.keys)
    }

    public func getString(forKey key: String) -> String {
        if let str = self.object![key] as? String {
            return str
        }

        return ""
    }

    public func getInt(forKey key: String) -> Int {
        if let i = self.object![key] as? Int {
            return i
        }

        return -1
    }
}
