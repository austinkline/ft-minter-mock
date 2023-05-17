import Minter from 0x20ab78fb1a2be624

import DapperUtilityCoinMinter from 0x20ab78fb1a2be624
import FlowUtilityTokenMinter from 0x20ab78fb1a2be624
import FlowTokenMinter from 0x20ab78fb1a2be624
import FiatTokenMinter from 0x20ab78fb1a2be624

import DapperUtilityCoin from 0x82ec283f88a62e65
import FlowUtilityToken from 0x82ec283f88a62e65
import FlowToken from 0x7e60df042a9c0868
import FiatToken from 0xa983fecbed621163

transaction {
    prepare(acct: AuthAccount) {
        let admin = acct.borrow<&Minter.Admin>(from: Minter.StoragePath) ?? panic("no admin found")

        let ducMinter <- DapperUtilityCoinMinter.createMinter(
            Type<@DapperUtilityCoin.Vault>(),
            Address(0x82ec283f88a62e65)
        )

        let futMinter <- FlowUtilityTokenMinter.createMinter(
            Type<@FlowUtilityToken.Vault>(),
            Address(0x82ec283f88a62e65)
        )

        let usdcMinter <- FiatTokenMinter.createMinter(
            Type<@FiatToken.Vault>(),
            Address(0xa983fecbed621163)
        )

        let flowTokenMinter <- FlowTokenMinter.createMinter(
            Type<@FlowToken.Vault>(),
            Address(0x8c5303eaa26202d6)
        )

        admin.registerMinter(<- ducMinter)
        admin.registerMinter(<- futMinter)
        admin.registerMinter(<- usdcMinter)
        admin.registerMinter(<- flowTokenMinter)

    }
}