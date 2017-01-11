import LoggerAPI
import Foundation

class Rapid {
    private(set) public static var currentInstance: Rapid = Rapid(processArguments: CommandLine.arguments)

    private var processArguments: [String]

    private var server: HHServer = HHServer()
    private var config: Configuration

    init(processArguments: [String]) {
        self.processArguments = processArguments

        Log.info("Rapid Server - Habbo Hotel emulation written in Swift & C")
        Log.info("  @author Leon")
        Log.info("Initialising core components")

        self.config = Configuration("./rapid.json")

        Configuration.setConfig(self.config)

        let dataStoreType = self.config["datastore"].getString(forKey: "type")

        if(dataStoreType == "redis") {
            DataStore.setInstance(RedbirdDataStore())
        } else if(dataStoreType == "mysql") {
            DataStore.setInstance(MySQLDataStore())
        }
        
        DataStore.getInstance().configure()
    }

    internal func start() {
        let host = self.config["server"].getString(forKey: "host")
        let port = self.config["server"].getInt(forKey: "port")
        let workers = self.config["server"].getInt(forKey: "workers")

        for _ in 1...workers {
            Log.info("Starting networking server on tcp://\(host):\(port)");
            self.server.initialise(host: host, port: port)   
        }

        Rapid.currentInstance = self
    }

    internal func getProcessArguments() -> [String] {
        return self.processArguments
    }
}
