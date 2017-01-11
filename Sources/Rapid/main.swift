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

if let roomModel = Rapid.roomModelService.findModel(byName: "model_a") {
    Log.info("Loaded room model with name model_a")
}

while(true) {
    if let line = readLine(strippingNewline: true) {
        switch line {
        case "help": 
            Log.info("help, stats")
        break

        case "stats":
            Log.info("players online: \(Rapid.sessionStore.sessionCount()!)")
        break

        default: 
            Log.info("Invalid command")
        break
        }
    }
}