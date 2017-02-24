//
// Created by leon on 24/02/17.
//

import Foundation

class AllowancesMessageComposer: MessageComposer {
    private var rank: Int
    private var perks: [PerkPermission]

    public init(forRank rank: Int, _  perks: [PerkPermission]) {
        self.rank = rank
        self.perks = perks
    }

    func compose(_ buffer: MessageBuffer) {
        buffer.writeInt(perks.count)

        for perk in self.perks {
            buffer.writeString(perk.title)
            buffer.writeString(perk.data)
            buffer.writeBool(perk.overrideRank ? perk.overrideDefault : (perk.minRank <= rank))
        }
    }

    func getId() -> Int {
        return Composers.CurrencyBalanceMessageComposer
    }
}
