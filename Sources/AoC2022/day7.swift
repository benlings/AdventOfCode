import Foundation
import AdventCore

public class FSNode {

    enum NodeType {
        case file
        case directory
    }

    init(parent: FSNode? = nil, type: NodeType) {
        self.parent = parent
        self.type = type
    }

    let type: NodeType
    var size: Int = 0
    var contents: [String: FSNode] = [:]
    weak var parent: FSNode? = nil

    var totalSize: Int {
        size + contents.values.map(\.totalSize).sum()
    }

    var directories: [FSNode] {
        if type == .directory {
            return [self] + contents.values.flatMap(\.directories)
        } else {
            return []
        }
    }

    public func smallDirectorySizes() -> Int {
        directories.map(\.totalSize).filter { $0 < 100000 }.sum()
    }

}

public extension FSNode {
    convenience init(_ input: String) {
        self.init(parent: nil, type: .directory)

        let scanner = Scanner(string: input)
        var cwd: FSNode = self
        while !scanner.isAtEnd {
            if let _ = scanner.scanString("$") {
                switch scanner.scanUpToCharacters(from: .whitespacesAndNewlines) {
                case "cd":
                    // cd argument
                    switch scanner.scanUpToCharacters(from: .whitespacesAndNewlines) {
                    case "/": cwd = self
                    case "..": cwd = cwd.parent!
                    case let dir?: cwd = cwd.contents[dir, setDefault: FSNode(parent: cwd, type: .directory)]
                    default: fatalError("cd must have an argument")
                    }
                case "ls":
                    // Scan output from ls
                    while !scanner.peekString("$") && !scanner.isAtEnd {
                        if let _ = scanner.scanString("dir"),
                           let _ = scanner.scanUpToCharacters(from: .whitespacesAndNewlines) {
                            // Ignore directory, we will create when cd-ing
                        } else if let size = scanner.scanInt(),
                                  let fileName = scanner.scanUpToCharacters(from: .whitespacesAndNewlines) {
                            let fsFile = FSNode(parent: cwd, type: .file)
                            fsFile.size = size
                            cwd.contents[fileName] = fsFile
                        } else {
                            fatalError("unknown ls output")
                        }
                    }
                default:
                    fatalError("Unknown command")
                }
            } else {
                fatalError("Invalid state")
            }
        }
    }
}

fileprivate let day7_input = Bundle.module.text(named: "day7")

public func day7_1() -> Int {
    FSNode(day7_input).smallDirectorySizes()
}

public func day7_2() -> Int {
    0
}
