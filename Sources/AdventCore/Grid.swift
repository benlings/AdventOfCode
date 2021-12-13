import Foundation


public struct Grid<Element> {
    var elements: [[Element]]

    public func row(_ index: Int) -> [Element] {
        elements[index]
    }

    public func rows() -> [[Element]] {
        elements
    }

    public var rowIndices: Array.Indices {
        elements.indices
    }

    public func column(_ index: Int) -> [Element] {
        elements.map { $0[index] }
    }

    public func columns() -> [[Element]] {
        columnIndices.map { column($0) }
    }

    public var columnIndices: Array.Indices {
        elements.first!.indices
    }

    public subscript(position: Offset) -> Element {
        get {
            elements[position.north][position.east]
        }
        set {
            elements[position.north][position.east] = newValue
        }
    }

}

public extension Grid where Element: RawRepresentable {
    init<C>(lines: C) where C: Collection, C.Element: Collection, C.Element.Element == Element.RawValue {
        self.elements = lines.map { $0.compactMap(Element.init) }
    }
}

public extension Grid {
    init(repeating element: Element, size: Offset) {
        self.elements = [[Element]](repeating: [Element](repeating: element, count: size.east), count: size.north)
    }
}


extension Grid: CustomStringConvertible where Element: CustomStringConvertible {
    public var description: String {
        elements.map { $0.map { $0.description }.joined() }.lines()
    }
}
