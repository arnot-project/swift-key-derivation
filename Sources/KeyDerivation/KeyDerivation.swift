public struct KeyDerivation {
    let rootKey: PrivateKey
    let purpose: UInt32 = 1852
    let coinType: UInt32 = 1815
    let account: UInt32 = 0
    let externalChainRole: UInt32 = 0
    let stakingKeyRole: UInt32 = 2

    public init(masterKey: [UInt8]) {
        self.rootKey = PrivateKey(key: Array(masterKey[0..<64]), chaincode: Array(masterKey[64..<96]))
    }
    
    public func utxoPublicKey(for index: UInt32) -> [UInt8] {
        rootKey
            .derive(harden(purpose))
            .derive(harden(coinType))
            .derive(harden(account))
            .derive(externalChainRole)
            .derive(index)
            .to_public()
    }
    
    public func stakeKey(for index: UInt32) -> [UInt8] {
        rootKey
            .derive(harden(purpose))
            .derive(harden(coinType))
            .derive(harden(account))
            .derive(stakingKeyRole)
            .derive(index)
            .to_public()
    }
}

func harden(_ num: UInt32) -> UInt32 {
    return 0x80000000 + num
}
