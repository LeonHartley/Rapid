cmake_minimum_required(VERSION 3.6)
project(Rapid)

add_custom_target(Rapid
        COMMAND swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        SOURCES Package.swift Sources/Rapid/main.swift Sources/Rapid/Rapid.swift Sources/Rapid/Networking/RapidServer.swift Sources/Rapid/Networking/MessageProcessor.swift Sources/Rapid/Networking/Sessions/Session.swift Sources/Rapid/Networking/Sessions/SessionManager.swift)
