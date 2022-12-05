//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Isis Silva on 11/27/22.
//

import Foundation

final class EmojiMemoryGame: ObservableObject {
  @Published private var model = createMemoryGame()
  
  typealias Card = MemoryGame<String>.Card
  
  static let emojis = ["🤼‍♀️", "🪂", "🏋🏻‍♀️", "🤸‍♀️", "⛹️‍♀️", "🤺", "🤾‍♀️", "🏌️‍♀️", "🏇", "🧘‍♀️", "🏄🏻‍♀️", "🏊🏻‍♀️", "🧗‍♀️"]
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 8) { emojis[$0] }
  }
 
  var cards: Array<Card> {
    model.cards
  }
  
  func choose(card: Card) {
    model.choose(card)
  }
  
  func shuffleElements() {
    model.shuffleElements()
  }
  
  func restart() {
    model = EmojiMemoryGame.createMemoryGame()
  }
  
}

