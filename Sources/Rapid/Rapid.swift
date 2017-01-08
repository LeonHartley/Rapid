import LoggerAPI
import Foundation

class Rapid {
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

        DataStore.setInstance(RedbirdDataStore())
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
    }

    internal func getProcessArguments() -> [String] {
        return self.processArguments
    }
}
