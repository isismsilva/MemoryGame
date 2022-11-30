//
//  Array+First.swift
//  MemoryGame
//
//  Created by Isis Silva on 11/30/22.
//

import Foundation

extension Array {
  var oneAndOnly: Element? {
    count == 1 ? first : nil
  }
}
