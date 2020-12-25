import Foundation
import AdventCore

public struct HotelCypher {

    let subject = 7
    let modulus = 20201227

    var cardPublicKey: Int
    var doorPublicKey: Int

    func findLoopSize(_ publicKey: Int) -> Int {
        var value = 1
        var loopCount = 0
        while value != publicKey {
            value = value * subject % modulus
            loopCount += 1
        }
        return loopCount
    }

    func transform(_ subjectNumber: Int, loopSize: Int) -> Int {
        var value = 1
        for _ in 0..<loopSize {
            value = value * subjectNumber % modulus
        }
        return value
    }

    public func findEncryptionKey() -> Int {
        let cardLoopSize = findLoopSize(cardPublicKey)
        return transform(doorPublicKey, loopSize: cardLoopSize)
    }

}

public extension HotelCypher {
    init(_ description: String) {
        let keys: [Int] = description.lines().ints()
        cardPublicKey = keys[0]
        doorPublicKey = keys[1]
    }
}

fileprivate let input = Bundle.module.text(named: "day25")

public func day25_1() -> Int {
    HotelCypher(input).findEncryptionKey()
}

public func day25_2() -> Int {
    0
}
