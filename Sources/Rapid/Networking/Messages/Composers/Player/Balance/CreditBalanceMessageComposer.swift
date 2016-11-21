
class CreditBalanceMessageComposer: MessageComposer {

    private var balance: Int

    public init(_  balance: Int) {
        self.balance = balance
    }    

    func compose(_ buffer: MessageBuffer) {
        buffer.writeString("\(self.balance).0")
    }

    func getId() -> Int {
        return Composers.CreditBalanceMessageComposer
    }
}