import LoggerAPI
import HeliumLogger 

// Initialise logging framework
let helium = HeliumLogger()
helium.format = "[(%date)] [(%type)] [(%file)] - (%msg)"

Log.logger = helium;

Log.info("Rapid Server      Habbo Server written in Swift")

let application = Rapid(processArguments: CommandLine.arguments);

application.start();