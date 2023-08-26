import Minter from 0xd9bc8eb0e90863f7

import DapperUtilityCoinMinter from 0xd9bc8eb0e90863f7
import FlowUtilityTokenMinter from 0xd9bc8eb0e90863f7
import FlowTokenMinter from 0xd9bc8eb0e90863f7
import FiatTokenMinter from 0xd9bc8eb0e90863f7

import DapperUtilityCoin from 0xead892083b3e2c6c
import FlowUtilityToken from 0xead892083b3e2c6c
import FlowToken from 0x1654653399040a61
import FiatToken from 0xb19436aae4d94622

transaction {
    prepare(acct: AuthAccount) {
        let admin = acct.borrow<&Minter.Admin>(from: Minter.StoragePath) ?? panic("no admin found")

        let ducMinter <- DapperUtilityCoinMinter.createMinter(
            Type<@DapperUtilityCoin.Vault>(),
            Address(0xead892083b3e2c6c)
        )

        let futMinter <- FlowUtilityTokenMinter.createMinter(
            Type<@FlowUtilityToken.Vault>(),
            Address(0xead892083b3e2c6c)
        )

        let usdcMinter <- FiatTokenMinter.createMinter(
            Type<@FiatToken.Vault>(),
            Address(0xb19436aae4d94622)
        )

        let flowTokenMinter <- FlowTokenMinter.createMinter(
            Type<@FlowToken.Vault>(),
            Address(0xe467b9dd11fa00df)
        )

        admin.registerMinter(<- ducMinter)
        admin.registerMinter(<- futMinter)
        admin.registerMinter(<- usdcMinter)
        admin.registerMinter(<- flowTokenMinter)

    }
}