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

    public func values() -> [Element] {
        elements.flatten()
    }

    public var columnIndices: Array.Indices {
        elements.first!.indices
    }

    public func contains(_ position: Offset) -> Bool {
        rowIndices.contains(position.north) && columnIndices.contains(position.east)
    }

    public subscript(position: Offset) -> Element {
        get {
            elements[position.north][position.east]
        }
        set {
            elements[position.north][position.east] = newValue
        }
    }

    public var size: Offset {
        return Offset(east: elements.first!.count, north: elements.count)
    }

    public func range() -> OffsetRange {
        OffsetRange(southWest: .zero, northEast: size - Offset(east: 1, north: 1))
    }

    public enum Boundary {
        // Non-ege
        case nonEdge
        /// Edge connected to the north
        case northEdge
        /// Edge not connected to the north
        case otherEdge
    }

    public func area(classify: (Element) -> Boundary) -> Int {
        var area = 0
        for row in rows() {
            var inside = false
            for element in row {
                switch classify(element) {
                case .nonEdge:
                    if inside { area += 1 }
                case .northEdge:
                    inside.toggle()
                case .otherEdge:
                    break
                }
            }
        }
        return area
    }

}

public extension Grid where Element: Equatable {
    func firstIndex(of element: Element) -> Offset? {
        guard let rowIndex = elements.firstIndex(where: { $0.contains(element) }),
              let columnIndex = elements[rowIndex].firstIndex(of: element)
        else { return nil }
        return Offset(east: columnIndex, north: rowIndex)
    }
}

public extension Grid {
    init(repeating element: Element, size: Offset) {
        self.elements = [[Element]](repeating: [Element](repeating: element, count: size.east), count: size.north)
    }
}

public extension Grid {

    init(_ description: String) where Element: RawRepresentable<Character> {
        self.init(description, conversion: { Element(rawValue: $0) })
    }

    init(_ description: String, conversion: (Character) -> Element?) {
        self.elements = description.lines().map { $0.compactMap(conversion) }
    }
}

extension Grid: CustomStringConvertible where Element: CustomStringConvertible {
    public var description: String {
        elements.map { $0.map(\.description).joined() }.lines()
    }
}

extension Grid: Equatable where Element: Equatable { }

extension Grid: Hashable where Element: Hashable { }

extension Set<Offset> {

    public var bottomRight: Offset {
        reduce(into: first!) { m, d in
            m.north = Swift.max(m.north, d.north)
            m.east = Swift.max(m.east, d.east)
        }
    }

    public var topLeft: Offset {
        reduce(into: first!) { m, d in
            m.north = Swift.min(m.north, d.north)
            m.east = Swift.min(m.east, d.east)
        }
    }

}

extension Grid<Bit> {

    public init(sparse: Set<Offset>) {
        let origin = sparse.topLeft
        self = Grid(repeating: Bit.off, size: (sparse.bottomRight - origin) + Offset(east: 1, north: 1))
        sparse.forEach { self[$0 - origin] = .on }
    }

    public func toSparse(base: Offset = .zero) -> Set<Offset> {
        var sparse = Set<Offset>()
        for row in rowIndices {
            for column in columnIndices {
                let offset = Offset(east: column, north: row)
                if self[offset] == .on {
                    sparse.insert(base + offset)
                }
            }
        }
        return sparse
    }
}
