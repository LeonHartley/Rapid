import LoggerAPI
import Foundation

class Configuration { 
    private static var config: Configuration?

    private var fullConfigData: [String:[String:Any]]?
    private var object: [String:Any]?

    init(_ configurationFileLocation: String) {
        do { 
            if let fileContent =  try? String(contentsOfFile: configurationFileLocation, encoding: .utf8).data(using: .utf8) {
                let parsedData = try JSONSerialization.jsonObject(with: fileContent!, options: []) as! [String:[String:Any]] 
                    
                self.fullConfigData = parsedData
                self.object = [:]
                
            }
        } catch {
            Log.error("Failed to load configuration file!")
        }
    }

    init(object: [String:Any]?) {
        self.object = object
    }

    public subscript(index: String) -> Configuration {
        if(self.fullConfigData != nil) {
            return Configuration(object: self.fullConfigData![index])
        }

        return Configuration(object: self.object![index] as? [String:Any])
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

    public static func getConfig() -> Configuration {
        if let configInstance = config {
            return configInstance
        }

        return Configuration(object: [:])
    }

    public static func setConfig(_ configInstance: Configuration) {
        config = configInstance
    }
}