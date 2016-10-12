import Foundation
import LoggerAPI
import HeliumLogger
import Habbo

// Initialise logging framework
let helium = HeliumLogger()
helium.format = "[(%date)] [(%type)] [(%file)] - (%msg)"

Log.logger = helium;

if let header = habbo_b64_encode(206) {

    print(String(cString: header))
    print(habbo_b64_decode(header))
}

let application = Rapid(processArguments: CommandLine.arguments);

application.start();