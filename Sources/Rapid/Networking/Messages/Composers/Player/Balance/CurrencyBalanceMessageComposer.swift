
class CurrencyBalanceMessageComposer: MessageComposer {
    private var currencies: [Int:Int]

    public init(_  currencies: [Int:Int]) {
        self.currencies = currencies
    }    

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(currencies.count)

        for (currencyId, balance) in self.currencies {
            buffer.writeInt(currencyId)
            buffer.writeInt(balance)
        }
    }

    func getId() -> Int {
        return Composers.CurrencyBalanceMessageComposer
    }
}