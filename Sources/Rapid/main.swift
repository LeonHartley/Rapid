import Foundation
import LoggerAPI
import HeliumLogger
import Habbo
import Dispatch

// Initialise logging framework
let helium = HeliumLogger()
helium.format = "[(%date)] [(%type)] [(%file)] - (%msg)"

Log.logger = helium

Rapid.currentInstance.start()

// If running in test mode, run any necessary tests here :)
Rapid.roomService.loadRoom(byId: 1)

while(true) {
    if let line = readLine(strippingNewline: true) {
        switch line {
        case "help": 
            Log.info("help, stats")
        break

        case "stats":
            if let playerCount = Rapid.sessionStore.sessionCount() {
                Log.info("players online: \(playerCount)")
            }
        break

        default: 
            Log.info("Invalid command")
        break
        }
    }
}