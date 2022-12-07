import Foundation
import AdventCore

public class FSNode {

    enum Entry {
        case file(size: Int)
        case directory(contents: [String: FSNode])
    }

    init(parent: FSNode? = nil, fileSize: Int? = nil) {
        self.parent = parent
        self.entry = fileSize.map(Entry.file) ?? .directory(contents: [:])
    }

    weak var parent: FSNode? = nil
    var entry: Entry

    subscript(name: String) -> FSNode? {
        get {
            switch entry {
            case .directory(let contents): return contents[name]
            case .file: return nil
            }
        }
        set {
            switch entry {
            case .directory(var contents):
                contents[name] = newValue
                entry = .directory(contents: contents)
            case .file: fatalError()
            }
        }
    }

    var size: Int {
        switch entry {
        case .directory(contents: let c): return c.values.map(\.size).sum()
        case .file(size: let s): return s
        }
    }

    var directories: [FSNode] {
        if case .directory(contents: let c) = entry {
            return [self] + c.values.flatMap(\.directories)
        } else {
            return []
        }
    }

    public func smallDirectorySizes() -> Int {
        directories.map(\.size).filter { $0 < 100000 }.sum()
    }

    public func sizeToDelete() -> Int {
        let currentFreeSpace = 70000000 - size
        let toFree = 30000000 - currentFreeSpace
        return directories.map(\.size).filter { $0 >= toFree }.min()!
    }

}

public extension FSNode {
    convenience init(_ input: String) {
        self.init(parent: nil)

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
                    case let dir?: cwd = cwd[dir]!
                    default: fatalError("cd must have an argument")
                    }
                case "ls":
                    // Scan output from ls
                    while !scanner.peekString("$") && !scanner.isAtEnd {
                        if let _ = scanner.scanString("dir"),
                           let dirName = scanner.scanUpToCharacters(from: .whitespacesAndNewlines) {
                            cwd[dirName] = FSNode(parent: cwd)
                        } else if let size = scanner.scanInt(),
                                  let fileName = scanner.scanUpToCharacters(from: .whitespacesAndNewlines) {
                            cwd[fileName] = FSNode(parent: cwd, fileSize: size)
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
    FSNode(day7_input).sizeToDelete()
}
