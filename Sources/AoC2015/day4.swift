import Foundation
import AdventCore
import CryptoKit

public struct AdventCoinMiner {
    var secretKey: String

    public func mineCoin(hexZeroPrefix: Int = 5) -> Int {
        let secretKeyData = Data(secretKey.utf8)
        let zeroes = Array(repeating: 0 as UInt8, count: hexZeroPrefix / 2)
        let zeroesString = String(Array(repeating: "0", count: hexZeroPrefix))
        return (1...).first {
            let digest = Insecure.MD5.hash(data: secretKeyData + Data($0.description.utf8))
            return digest.starts(with: zeroes) && digest.hex.hasPrefix(zeroesString)
        }!
    }
}

public extension AdventCoinMiner {
    init(_ description: String) {
        secretKey = description
    }
}

fileprivate let input = "yzbqklnj"

public func day4_1() -> Int {
    AdventCoinMiner(input).mineCoin()
}

public func day4_2() -> Int {
    AdventCoinMiner(input).mineCoin(hexZeroPrefix: 6)
}
