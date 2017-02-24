import LoggerAPI
import Foundation

class Configuration: JSONParser {
    private static var config: Configuration?

    private var fullConfigData: [String:[String:Any]]?
    private var object: [String:Any]?

    init(_ configurationFileLocation: String) {
        super.init(fromFile: configurationFileLocation)
    }

    public static func getConfig() -> Configuration {
        if let configInstance = config {
            return configInstance
        }

        return Configuration("./rapid.json")
    }

    public static func setConfig(_ configInstance: Configuration) {
        config = configInstance
    }
}