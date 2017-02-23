import LoggerAPI
import Foundation

class Rapid {
    private(set) public static var currentInstance: Rapid = Rapid(processArguments: CommandLine.arguments)

    private(set) public var configurationFile = "./rapid.json"

    private var processArguments: [String]

    private var server: HHServer = HHServer()
    private var config: Configuration

    init(processArguments: [String]) {
        self.processArguments = processArguments

        Log.info("Rapid Server - Habbo Hotel emulation written in Swift & C")
        Log.info("  @author Leon")
        Log.info("Initialising core components")

        for argument in self.processArguments {
            if(argument.hasPrefix("--config=")) {
                self.configurationFile = argument.substring(from: 9)
            }

            if(argument.hasPrefix("--build-catalog")) {
                // Build the catalog.
                CatalogBuilder.build()
            }
        }

        self.config = Configuration(self.configurationFile)

        Configuration.setConfig(self.config)

        let dataStoreType = self.config["datastore"].getString(forKey: "type")

        if(dataStoreType == "redis") {
            DataStore.setInstance(RedbirdDataStore())
        } else if(dataStoreType == "mysql") {
            DataStore.setInstance(MySQLDataStore())
        }

        DataStore.getInstance().configure()
    }

    internal func parseArguments() {

    }

    internal func start() {
        let host = self.config["server"].getString(forKey: "host")
        let port = self.config["server"].getInt(forKey: "port")
        let workers = self.config["server"].getInt(forKey: "workers")


        Rapid.currentInstance = self

        Rapid.roomService.initialise()
        Rapid.catalogService.initialise()

        for _ in 1...workers {
            Log.info("Starting networking server on tcp://\(host):\(port)");
            self.server.initialise(host: host, port: port)   
        }
    }

    internal func getProcessArguments() -> [String] {
        return self.processArguments
    }
}
