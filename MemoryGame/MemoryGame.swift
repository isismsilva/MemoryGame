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
  
  private var secondFaceUpCard: Int? {
    didSet {
      guard let firstIndex = indexOfOneAndOnlyFaceUpCard, let secondIndex = self.secondFaceUpCard else { return }
      let isMAtched = cards[firstIndex].content == cards[secondIndex].content
      
      if isMAtched {
        cards[firstIndex].isMatched = true
        cards[secondIndex].isMatched = true
      } else {
        indexOfOneAndOnlyFaceUpCard = nil
      }
      
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
    
    guard (indexOfOneAndOnlyFaceUpCard != nil) else {
      indexOfOneAndOnlyFaceUpCard = index
      cards[index].isFaceUp = true
      return
    }
      secondFaceUpCard = index
    cards[index].isFaceUp = true
    
    print("cards: \(cards)")
  }
  
  struct Card {
    let id: Int
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    let content: CardContent
  }
}
