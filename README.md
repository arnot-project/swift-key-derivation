# KeyDerivation

This package implements key derivation system based of 5 levels:

m / purpose' / coin_type' / account' / role / index

As described in CIP 1852[1], which extends BIP44[2], it is using purpose 1852, coin type 1815.
Supported roles are: External chain and Staking Key.


## Documentation and white papers:

[1] [CIP 1852](https://cips.cardano.org/cips/cip1852/)
[2] [BIP44](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)

