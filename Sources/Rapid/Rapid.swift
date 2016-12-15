import LoggerAPI

class Rapid {
    private var processArguments: [String]

    private var server: HHServer = HHServer()

    init(processArguments: [String]) {
        self.processArguments = processArguments

        Log.info("Rapid Server - Habbo Hotel emulation written in Swift & C")
        Log.info("  @author Leon")
        Log.info("Initialising core components")

        DataStore.setInstance(RedbirdDataStore())
        DataStore.getInstance().configure()
    }

    internal func start() {
        // 2 networking workers. todo: make this configurable
        self.server.initialise(host: "0.0.0.0", port: 3000)
        self.server.initialise(host: "0.0.0.0", port: 3000)
    }

    internal func getProcessArguments() -> [String] {
        return self.processArguments
    }
}
