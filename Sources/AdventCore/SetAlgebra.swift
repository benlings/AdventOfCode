import Foundation

public extension SetAlgebra {
    mutating func toggle(_ element: Element) {
        if self.contains(element) {
            self.remove(element)
        } else {
            self.insert(element)
        }
    }
}
