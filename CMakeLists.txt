cmake_minimum_required(VERSION 3.6)
project(Rapid)

add_custom_target(
        COMMAND ./build-all
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        SOURCES     Modules/Habbo/Sources/Habbo/include/habbo.h
        Modules/Habbo/Sources/Habbo/include/hhserver.h
        Modules/Habbo/Sources/Habbo/habbo.c
        Modules/Habbo/Sources/Habbo/hhserver.c
        Packages/CMySQL-2.0.0/mysql.h
        Packages/CUV-1.0.0/cuv.h
        Packages/Gzip-3.1.2/zlib/include.h
        Packages/Habbo-1.0.0/Sources/Habbo/include/habbo.h
        Packages/Habbo-1.0.0/Sources/Habbo/include/hhserver.h
        Packages/Habbo-1.0.0/Sources/Habbo/habbo.c
        Packages/Habbo-1.0.0/Sources/Habbo/hhserver.c
        "Packages/MySQL-0.6.1/OSX Projects/MySQL/MySQL/MySQL.h"
        "Packages/MySQL-0.6.1/OSX Projects/SQLFormatter/SQLFormatter/SQLFormatter.h"
        Packages/zlib-0.0.1/zconf.h
        Packages/zlib-0.0.1/zlib.h
        Sources/Rapid/Networking/HH/HHServer.swift
        Sources/Rapid/Networking/HH/HHServerConfig.swift
        Sources/Rapid/Networking/Messages/Composers/Handshake/AuthenticationOKMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Handshake/AvailabilityStatusMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Navigator/FavouriteRoomsMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Notifications/MotdNotificationMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Player/Balance/CreditBalanceMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Player/Balance/CurrencyBalanceMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Player/Data/HomeRoomMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Player/Data/PlayerObjectMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Player/Permissions/FuserightsMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Player/Settings/ClientSettingsMessageComposer.swift
        Sources/Rapid/Networking/Messages/Composers/Composers.swift
        Sources/Rapid/Networking/Messages/Composers/MessageComposer.swift
        Sources/Rapid/Networking/Messages/Events/Handshake/CheckReleaseMessageEvent.swift
        Sources/Rapid/Networking/Messages/Events/Handshake/SSOTicketMessageEvent.swift
        Sources/Rapid/Networking/Messages/Events/Player/Initialisation/PlayerDataMessageEvent.swift
        Sources/Rapid/Networking/Messages/Events/Events.swift
        Sources/Rapid/Networking/Messages/Events/MessageEvent.swift
        Sources/Rapid/Networking/Messages/Events/MessageHandler.swift
        Sources/Rapid/Networking/Messages/Parsers/Handshake/CheckReleaseMessageParser.swift
        Sources/Rapid/Networking/Messages/Parsers/Handshake/SSOTicketMessageParser.swift
        Sources/Rapid/Networking/Messages/Parsers/Player/PlayerDataMessageParser.swift
        Sources/Rapid/Networking/Messages/Parsers/MessageParser.swift
        Sources/Rapid/Networking/Messages/MessageBuffer.swift
        Sources/Rapid/Networking/Sessions/Session.swift
        Sources/Rapid/Networking/Sessions/SessionStore.swift
        Sources/Rapid/Networking/RapidServer.swift
        Sources/Rapid/Services/Players/Types/Player.swift
        Sources/Rapid/Services/Players/Types/PlayerData.swift
        Sources/Rapid/Services/Players/PlayerService.swift
        Sources/Rapid/Storage/MySQL/Configuration/DataStoreConfiguration.swift
        Sources/Rapid/Storage/MySQL/Models/Players/MySQLPlayerModel.swift
        Sources/Rapid/Storage/MySQL/Repositories/MySQLPlayerRepository.swift
        Sources/Rapid/Storage/MySQL/Repositories/MySQLRepository.swift
        Sources/Rapid/Storage/MySQL/MySQLDataStore.swift
        Sources/Rapid/Storage/Protocol/Repositories/PlayerRepository.swift
        Sources/Rapid/Storage/Redis/Repositories/RedbirdPlayerRepository.swift
        Sources/Rapid/Storage/Redis/Repositories/RedbirdRepository.swift
        Sources/Rapid/Storage/Redis/Transactions/RedbirdTransaction.swift
        Sources/Rapid/Storage/Redis/RedbirdDataStore.swift
        Sources/Rapid/Storage/DataStore.swift
        Sources/Rapid/Threading/Dispatch.swift
        Sources/Rapid/Utilities/Memory.swift
        Sources/Rapid/main.swift
        Sources/Rapid/Rapid.swift)