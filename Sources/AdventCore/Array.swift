//
//  File.swift
//  
//
//  Created by Ben Lings on 21/12/2020.
//

import Foundation

public extension Array {
    mutating func sort<T>(on selector: (Element) -> T) where T : Comparable {
        sort {
            selector($0) < selector($1)
        }
    }
}

public extension Array where Element == String {
    func lines() -> String {
        joined(separator: "\n")
    }

    func commaSeparated() -> String {
        joined(separator: ",")
    }
}
