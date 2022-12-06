//
//  File.swift
//  
//
//  Created by Ben Lings on 21/12/2020.
//

import Foundation

public extension Array {
    mutating func sort(on selector: (Element) -> some Comparable) {
        sort {
            selector($0) < selector($1)
        }
    }
}

public extension Array<String> {
    func lines() -> String {
        joined(separator: "\n")
    }

    func commaSeparated() -> String {
        joined(separator: ",")
    }
}
