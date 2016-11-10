import PackageDescription

let package = Package(
        name: "Rapid",
        dependencies: [
                .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 0),
                .Package(url: "https://github.com/IBM-Swift/Kitura-net.git", majorVersion: 1, minor: 0),
                .Package(url: "https://github.com/Trevi-Swift/swift-libuv.git", majorVersion: 0),
                .Package(url: "./Modules/Habbo/", majorVersion: 1, minor: 0),
                .Package(url: "https://github.com/novi/mysql-swift.git", majorVersion: 0)
        ])
