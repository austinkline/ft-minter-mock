import "Minter"
import "FungibleToken"
import "DapperUtilityCoin"

pub contract DapperUtilityCoinMinter {
    pub resource FungibleTokenMinter: Minter.FungibleTokenMinter {
        pub let type: Type
        pub let addr: Address

        pub fun mintTokens(acct: AuthAccount, amount: UFix64): @FungibleToken.Vault {
            let mainVault = acct.borrow<&DapperUtilityCoin.Vault>(from: /storage/dapperUtilityCoinVault)
                ?? panic("vault not found")
            let tokens <- mainVault.withdraw(amount: amount)
            return <- tokens
        }

        init(_ t: Type, _ a: Address) {
            self.type = t
            self.addr = a
        }
    }

    pub fun createMinter(_ t: Type, _ a: Address): @FungibleTokenMinter {
        return <- create FungibleTokenMinter(t, a)
    }
}