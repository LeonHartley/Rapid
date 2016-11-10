import LoggerAPI

class CheckReleaseMessageEvent: MessageEvent<CheckReleaseMessageParser> {
    override func handle(_ parser: CheckReleaseMessageParser) {
        Log.info("client connected with release: \(parser.clientRelease)")
    }
}