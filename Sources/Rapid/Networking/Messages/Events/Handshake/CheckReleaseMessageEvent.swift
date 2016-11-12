import LoggerAPI

class CheckReleaseMessageEvent: MessageEvent<CheckReleaseMessageParser> {
    override func handle(_ parser: CheckReleaseMessageParser) {
        Log.debug("client connected with release: \(parser.clientRelease)")
    }
}