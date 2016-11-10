import KituraNet
import LoggerAPI

class MessageDelegate: ServerDelegate {

    func handle(request: ServerRequest, response: ServerResponse) {
        Log.info("received data")
    }
}
