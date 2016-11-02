import Foundation
import LoggerAPI
import HeliumLogger
import Habbo

// Initialise logging framework
let helium = HeliumLogger()
helium.format = "[(%date)] [(%type)] [(%file)] - (%msg)"

Log.logger = helium

let application = Rapid(processArguments: CommandLine.arguments)

application.start()