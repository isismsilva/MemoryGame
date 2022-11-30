//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Isis Silva on 11/27/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  
  private(set) var cards: Array<Card>
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = Array<Card>()
    
    for index in 0..<numberOfPairsOfCards {
      cards.append(Card(id: index * 2, content: createCardContent(index)))
      cards.append(Card(id: index * 2 + 1, content: createCardContent(index)))
    }
  }
  
  private var indexOfOneAndOnlyFaceUpCard: Int?
  {
    get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
    set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }}
  }
  
  mutating func choose(_ card: Card) {
    guard let index = cards.firstIndex(where: { $0.id == card.id }),
          !cards[index].isFaceUp,
          !cards[index].isMatched
    else {return }
    if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
      if cards[index].content == cards[potentialMatchIndex].content {
        cards[index].isMatched = true
        cards[potentialMatchIndex].isMatched = true
      }
      cards[index].isFaceUp = true
    } else {
      indexOfOneAndOnlyFaceUpCard = index
    }
  }
  
  struct Card {
    let id: Int
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    let content: CardContent
  }
}
