//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Isis Silva on 11/27/22.
//

import Foundation

final class EmojiMemoryGame: ObservableObject {
  @Published private var model = MemoryGame<String>(numberOfPairsOfCards: 4) { emojis[$0] }
  
  static let emojis = ["🤼‍♀️", "🪂", "🏋🏻‍♀️", "🤸‍♀️", "⛹️‍♀️", "🤺", "🤾‍♀️", "🏌️‍♀️", "🏇", "🧘‍♀️", "🏄🏻‍♀️", "🏊🏻‍♀️", "🧗‍♀️"]
 
  typealias card = MemoryGame<String>.Card

  func choose(card: card) {
    model.choose(card)
  }
  
  var cards: Array<card> {
    model.cards
  }
  
}

