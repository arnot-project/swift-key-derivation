import CommonCryptoWrapper
import NaCl

struct PrivateKey {
    let key: [UInt8]
    let chaincode: [UInt8]
    let nacl = NaCl()
    
    func to_public() -> [UInt8] {
        nacl.toPublic(key)
    }

    func derive(_ index: UInt32) -> PrivateKey {
        let newPrivateKey = PrivateKey(key: key, chaincode: chaincode)
        let seri = le32(UInt32(index))

        let kl = Array(newPrivateKey.key[0..<32])
        let kr = Array(newPrivateKey.key[32..<64])

        var zmac : [UInt8] = []
        var imac : [UInt8] = []

        if (index >= 0x80000000) {
            zmac.append(UInt8(0x00))
            zmac.append(contentsOf: newPrivateKey.key)
            zmac.append(contentsOf: seri)

            imac.append(0x01)
            imac.append(contentsOf: newPrivateKey.key)
            imac.append(contentsOf: seri)
        } else {
            let pk = to_public()
            zmac.append(UInt8(0x02))
            zmac.append(contentsOf: pk)
            zmac.append(contentsOf: seri)

            imac.append(0x03)
            imac.append(contentsOf: pk)
            imac.append(contentsOf: seri)
        }

        let zhmacSha512 = hmacWithSHA512(key: chaincode, data: zmac)
        let zl = Array(zhmacSha512[0..<32])
        let zr = Array(zhmacSha512[32..<64])
        let left = add28Mul8(kl, zl)
        let right = add256Bits(kr, zr)
        let hmacSha512 = hmacWithSHA512(key: chaincode, data: imac)

        return PrivateKey(key: left + right, chaincode: Array(hmacSha512[32..<64]))
    }
    
    private func le32(_ i: UInt32) -> [UInt8] {
        let mask: UInt32 = 0b1111_1111
        return
            [
                UInt8(i & mask),
                UInt8((i >> 8) & mask),
                UInt8((i >> 16) & mask),
                UInt8((i >> 24) & mask)
            ]
    }
    
    private func add28Mul8(_ x: [UInt8], _ y: [UInt8]) -> [UInt8] {
        assert(x.count == 32)
        assert(y.count == 32)
        
        var carry: UInt16 = 0
        var out: [UInt8] = Array(repeating: 0, count:32)
        
        for i in 0..<28 {
            let r = UInt16(x[i]) + (UInt16(y[i]) << 3) + carry
            out[i] = UInt8(r & 0xff)
            carry = r >> 8
        }
            
        for i in 28..<32 {
            let r = UInt16(x[i]) + carry
            out[i] = UInt8(r & 0xff)
            carry = r >> 8
        }
        
        return out
    }
    
    private func add256Bits(_ x: [UInt8], _ y: [UInt8]) -> [UInt8] {
        assert(x.count == 32)
        assert(y.count == 32)
        
        let mask: UInt16 = 0b1111_1111
        
        var carry: UInt16 = 0
        
        var out: [UInt8] = Array(repeating: 0, count:32)
        
        for i in 0..<32 {
            let r = UInt16(x[i]) + UInt16(y[i]) + carry
            out[i] = UInt8(r & mask)
            carry = r >> 8
        }
        return out
    }
}

