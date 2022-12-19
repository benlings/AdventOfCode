import Foundation
import AdventCore
import Algorithms

struct Rock {
    var shape: Grid<Bit>
    var location: Offset

    func pattern() -> Set<Offset> {
        shape.toSparse(base: location)
    }

    static let shape1 = Grid("""
    ####
    """, conversion: Bit.init(pixel:))
    static let shape2 = Grid("""
    .#.
    ###
    .#.
    """, conversion: Bit.init(pixel:))
    // TODO fix Grid orientation north == down (!)
    static let shape3 = Grid("""
    ###
    ..#
    ..#
    """, conversion: Bit.init(pixel:))
    static let shape4 = Grid("""
    #
    #
    #
    #
    """, conversion: Bit.init(pixel:))
    static let shape5 = Grid("""
    ##
    ##
    """, conversion: Bit.init(pixel:))

    static let shapes = [shape1, shape2, shape3, shape4, shape5].cycled()

}

enum Jet : Character {
    case left = "<"
    case right = ">"
}

public struct Chamber {

    var jets: [Jet]
    var rocks = Set<Offset>()
    var maxHeight = 0

    public func maxHeight(count: Int) -> Int {
        var copy = self
        copy.simulate(count: count)
        return copy.maxHeight
    }

    mutating func simulate(count: Int) {
        var jetIterator = jets.cycled().makeIterator()
        var shapesIterator = Rock.shapes.makeIterator()
        for _ in 0..<count {
            var rock = Rock(shape: shapesIterator.next()!,
                            location: Offset(east: 2, north: maxHeight + 3))
            repeat {
                move(rock: &rock, direction: jetIterator.next()!)
            } while moveDown(rock: &rock)
            rocks.formUnion(rock.pattern())
            maxHeight = max(maxHeight, rock.location.north + rock.shape.size.north)
        }
    }

    func move(rock: inout Rock, direction: Jet) {
        var moved = rock
        if direction == .right && rock.location.east + rock.shape.size.east < 7 {
            moved.location.east += 1
        } else if direction == .left && rock.location.east > 0 {
            moved.location.east -= 1
        } else {
            return
        }
        if maxHeight < moved.location.north || rocks.isDisjoint(with: moved.pattern()) {
            rock = moved
        }
    }

    func moveDown(rock: inout Rock) -> Bool {
        var moved = rock
        if rock.location.north > 0 {
            moved.location.north -= 1
        } else {
            return false
        }
        if maxHeight < moved.location.north || rocks.isDisjoint(with: moved.pattern()) {
            rock = moved
            return true
        }
        return false
    }

}

public extension Chamber {
    init(_ input: String) {
        jets = input.compactMap(Jet.init(rawValue:))
    }
}

fileprivate let day17_input = Bundle.module.text(named: "day17")

public func day17_1() -> Int {
    Chamber(day17_input).maxHeight(count: 2022)
}

public func day17_2() -> Int {
    0
}
