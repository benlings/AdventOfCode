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

}

public func smallDirectorySizes(node: FSNode) -> Int {
    var total = 0
    var toVisit = [node]
    while let n = toVisit.popLast() {
        let size = n.totalSize
        if size <= 100000 && n.type == .directory {
            total += size
        }
        toVisit.append(contentsOf: n.contents.values)
    }
    return total
}

public func buildFileSystem(_ input: String) -> FSNode {
    let scanner = Scanner(string: input)
    let root = FSNode(parent: nil, type: .directory)
    var cwd = root
    while !scanner.isAtEnd {
        if let _ = scanner.scanString("$") {
            switch scanner.scanUpToCharacters(from: .whitespacesAndNewlines) {
            case "cd":
                // cd argument
                switch scanner.scanUpToCharacters(from: .whitespacesAndNewlines) {
                case "/": cwd = root
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
    return root
}

fileprivate let day7_input = Bundle.module.text(named: "day7")

public func day7_1() -> Int {
    smallDirectorySizes(node: buildFileSystem(day7_input))
}

public func day7_2() -> Int {
    0
}
