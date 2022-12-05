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
    shuffleElements()
  }
  
  private var secondFaceUpCard: Int? {
    didSet {
      guard let index1 = indexOfOneAndOnlyFaceUpCard, let index2 = self.secondFaceUpCard else { return }
      if cards[index1].content == cards[index2].content {
        cards[index1].isMatched = true
        cards[index2].isMatched = true
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
    
    guard indexOfOneAndOnlyFaceUpCard != nil else {
      indexOfOneAndOnlyFaceUpCard = index
      return
    }
    secondFaceUpCard = index
    cards[index].isFaceUp = true
  }
  
  mutating func shuffleElements() {
    cards.shuffle()
  }
  
  struct Card: Identifiable {
    let id: Int
    var isFaceUp: Bool = false { didSet { isFaceUp ? startUsingBonusTime() : stopUsingBonusTime() }}
    var isMatched: Bool = false { didSet { stopUsingBonusTime() }}
    let content: CardContent

    var bonusTimeLimit: TimeInterval = 6
    var lastFaceUpDate: Date?
    var pastFaceUpTime: TimeInterval = 0
    
    var faceUpTime: TimeInterval {
      if let lastFaceUpDate = lastFaceUpDate {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        return pastFaceUpTime
      }
    }

    var bonusTimeRemaining: Double {
      max(0, bonusTimeLimit - faceUpTime)
    }
    
    var bonusRemaining: Double {
      (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    
    var isConsumingBonusTime: Bool {
      isFaceUp && !isMatched && bonusTimeRemaining > 0
    }
    
    private mutating func startUsingBonusTime() {
      if isConsumingBonusTime, lastFaceUpDate == nil {
        lastFaceUpDate = Date()
      }
    }
    
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      lastFaceUpDate = nil
    }
  }
  
}
