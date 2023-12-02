//
//  File.swift
//  
//
//  Created by Ben Lings on 02/12/2023.
//

extension Comparable {
  public mutating func formMax(_ other: Self) {
    self = Swift.max(self, other)
  }
}

