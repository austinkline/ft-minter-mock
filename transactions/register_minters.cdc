import "Minter"
import "DapperUtilityCoinMinter"
import "FlowTokenMinter"
import "DapperUtilityCoin"
import "FlowToken"
import "AddressUtils"

transaction {
    prepare(acct: auth(Storage, Capabilities) &Account) {
        let admin = acct.storage.borrow<&Minter.Admin>(from: Minter.StoragePath) ?? panic("no admin found")

        let network = AddressUtils.currentNetwork()

        let ducMinterAddress = network == "mainnet" ? Address(0xead892083b3e2c6c) : Address(0x82ec283f88a62e65)
        let flowMinterAddress = network == "mainnet" ? Address(0xe467b9dd11fa00df) : Address(0x8c5303eaa26202d6)

        let ducMinter <- DapperUtilityCoinMinter.createMinter(
            Type<@DapperUtilityCoin.Vault>(),
            ducMinterAddress
        )

        let flowTokenMinter <- FlowTokenMinter.createMinter(
            Type<@FlowToken.Vault>(),
            flowMinterAddress
        )

        admin.registerMinter(<- ducMinter)
        admin.registerMinter(<- flowTokenMinter)

    }
}