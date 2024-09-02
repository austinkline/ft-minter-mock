import "Minter"
import "FungibleToken"
import "FlowToken"

access(all) contract FlowTokenMinter {
    access(all) resource FungibleTokenMinter: Minter.FungibleTokenMinter {
        access(all) let type: Type
        access(all) let addr: Address

        access(all) fun mintTokens(acct: auth(Storage, Capabilities) &Account, amount: UFix64): @{FungibleToken.Vault} {
            let admin = acct.storage.borrow<&FlowToken.Administrator>(from: /storage/flowTokenAdmin)
                ?? panic("admin not found")
            let minter <- admin.createNewMinter(allowedAmount: amount)
            let tokens <- minter.mintTokens(amount: amount)

            destroy minter
            return <- tokens
        }

        init(_ t: Type, _ a: Address) {
            self.type = t
            self.addr = a
        }
    }

    access(all) fun createMinter(_ t: Type, _ a: Address): @FungibleTokenMinter {
        return <- create FungibleTokenMinter(t, a)
    }
}