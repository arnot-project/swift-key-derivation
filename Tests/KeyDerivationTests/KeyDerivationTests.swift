import XCTest
import KeyDerivation

final class KeyDerivationTests: XCTestCase {
    
    func testUTXOPublicKeyWithMasterKeyZerosAndIndexZeroReturnsCorrectUTXO() {
        // given
        let masterKey = [UInt8](repeating: 0, count: 96)
        let sut: KeyDerivation = KeyDerivation(masterKey: masterKey)
        let expectedArray: [UInt8] = [
            231, 98, 235, 42, 245, 144, 84, 16,
            140, 122, 171, 47, 103, 59, 66, 132,
            38, 116, 89, 178, 120, 42, 63, 112,
            54, 92, 101, 105, 83, 28, 10, 178
        ]
        
        // when
        let utxoPublicKey = sut.utxoPublicKey(for: 0)
        
        // then
        XCTAssertEqual(utxoPublicKey, expectedArray)
    }
    
    func testUTXOPublicKeyWithMasterKeyOnesAndIndexZeroReturnsCorrectUTXO() {
        // given
        let masterKey = [UInt8](repeating: 1, count: 96)
        let sut: KeyDerivation = KeyDerivation(masterKey: masterKey)
        let expectedArray: [UInt8] = [
            104, 123, 157, 146, 126, 147, 190, 48,
            148, 244, 184, 218, 161, 8, 126, 64,
            254, 127, 51, 74, 25, 148, 169, 223,
            160, 250, 176, 108, 239, 89, 68, 58
        ]
        
        // when
        let utxoPublicKey = sut.utxoPublicKey(for: 0)
        
        // then
        XCTAssertEqual(utxoPublicKey, expectedArray)
    }
    
    func testUTXOPublicKeyWithMasterKeyZerosAndIndexOneReturnsCorrectUTXO() {
        // given
        let masterKey = [UInt8](repeating: 0, count: 96)
        let sut: KeyDerivation = KeyDerivation(masterKey: masterKey)
        let expectedArray: [UInt8] = [
            161, 143, 82, 95, 247, 189, 32, 92,
            30, 234, 103, 207, 209, 174, 84, 150,
            218, 108, 76, 234, 144, 155, 109, 145,
            250, 65, 140, 43, 181, 23, 60, 207
        ]
        
        // when
        let utxoPublicKey = sut.utxoPublicKey(for: 1)
        
        // then
        XCTAssertEqual(utxoPublicKey, expectedArray)
    }
    
    func testStakeKeyWithMasterKeyZerosAndIndexZeroReturnsCorrectValue() {
        // given
        let masterKey = [UInt8](repeating: 0, count: 96)
        let sut: KeyDerivation = KeyDerivation(masterKey: masterKey)
        let expectedArray: [UInt8] = [
            251, 104, 33, 34, 27, 102, 158, 239,
            125, 254, 193, 201, 220, 50, 171, 123,
            41, 205, 152, 94, 178, 18, 88, 214,
            28, 125, 102, 141, 169, 141, 55, 241
        ]
        
        // when
        let stakeKey = sut.stakeKey(for: 0)
        
        // then
        XCTAssertEqual(stakeKey, expectedArray)
    }
}
