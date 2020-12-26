import Foundation
import AdventCore
import CryptoKit

public struct AdventCoinMiner {
    var secretKey: String

    public func mineCoin() -> Int {
        let secretKeyData = Data(secretKey.utf8)
        return (1...).first {
            let digest = Insecure.MD5.hash(data: secretKeyData + Data($0.description.utf8))
            return digest.starts(with: [0, 0]) && digest.hex.hasPrefix("00000")
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
    0
}
