//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Isis Silva on 11/27/22.
//

import SwiftUI

final class EmojiMemoryGame: ObservableObject {
  @Published private var model = createMemoryGame()
  @Published var dealt = Set<Int>()
  
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
    dealt = []
    model = EmojiMemoryGame.createMemoryGame()
  }
  
  func deal(_ card: MemoryGame<String>.Card) {
    dealt.insert(card.id)
  }
  
  func isUndealt(_ card: MemoryGame<String>.Card) -> Bool {
    !dealt.contains(card.id)
  }
  
  func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
    var delay = 0.0
    if let index = cards.firstIndex(where: { $0.id == card.id }) {
      delay = Double(index) * (1 / Double(cards.count))
    }
    return .easeInOut(duration: 1).delay(delay)
  }
  
  func zIndex(of card: Card) -> Double {
    -Double(cards.firstIndex(where: { $0.id == card.id }) ?? 0)
  }
}

