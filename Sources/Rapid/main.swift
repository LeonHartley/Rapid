import Foundation
import LoggerAPI
import HeliumLogger
import Habbo

// Initialise logging framework
let helium = HeliumLogger()
helium.format = "[(%date)] [(%type)] [(%file)] - (%msg)"

Log.logger = helium

let messageBuffer = MessageBuffer(buffer: hh_buffer_create(1024))

messageBuffer.writeString("hi")
messageBuffer.reset()

print(messageBuffer.readString())

let application = Rapid(processArguments: CommandLine.arguments)

application.start()