import PackageDescription

let package = Package(
        name: "Rapid",
        dependencies: [
                .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 0),
                .Package(url: "https://github.com/vapor/redbird.git", majorVersion: 0, minor: 10),
                .Package(url: "./Modules/Habbo/", majorVersion: 1, minor: 0),
                .Package(url: "./Modules/Coerce/", majorVersion: 1, minor: 0),
                .Package(url: "https://github.com/novi/mysql-swift.git", majorVersion: 0),
                .Package(url: "https://github.com/1024jp/GzipSwift.git", majorVersion: 3, minor: 1),
                .Package(url: "https://github.com/LeonHartley/Libuv-swift.git", majorVersion: 1, minor: 0),
               // .Package(url: "https://github.com/OpenKitten/MongoKitten.git", majorVersion: 3)
                .Package(url: "https://github.com/Zewo/XML.git", majorVersion: 0)
        ])
