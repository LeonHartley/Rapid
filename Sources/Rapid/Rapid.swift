import Libuv 

class Rapid {
    private var processArguments: [String]

    private var server: HHServer?

    init(processArguments: [String]) {
        self.processArguments = processArguments

        DataStore.setInstance(MySQLDataStore())
        DataStore.getInstance().configure()

        // HHServer is a server implemented in C
        self.server = HHServer(host: "0.0.0.0", port: 3000)
    }

    internal func start() {
        // Initialise all other components before initialising the server service
        //self.server?.startServer(port: 3000, backlog: 100)
    }

    internal func getProcessArguments() -> [String] {
        return self.processArguments
    }
}
