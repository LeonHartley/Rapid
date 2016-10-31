class Rapid {
    private var processArguments: [String]

    private var server: RapidServer?

    init(processArguments: [String]) {
        self.processArguments = processArguments

        self.server = RapidServer()
    }

    internal func start() {
        // Initialise all other components before initialising the server service
        self.server?.startServer(port: 3000, backlog: 100)
    }

    internal func getProcessArguments() -> [String] {
        return self.processArguments
    }
}
