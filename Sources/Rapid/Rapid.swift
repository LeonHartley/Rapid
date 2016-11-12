import LoggerAPI

class Rapid {
    private var processArguments: [String]

    private var server: HHServer?

    init(processArguments: [String]) {
        self.processArguments = processArguments

        Log.info("Rapid Server - Habbo Hotel emulation written in Swift & C")
        Log.info("  @author Leon")
        Log.info("Initialising core components")

        DataStore.setInstance(MySQLDataStore())
        DataStore.getInstance().configure()
    }

    internal func start() {
        // HHServer is a server implemented in C
        self.server = HHServer(host: "0.0.0.0", port: 3000)
    }

    internal func getProcessArguments() -> [String] {
        return self.processArguments
    }
}
