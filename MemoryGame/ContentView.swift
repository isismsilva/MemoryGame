//
//  ContentView.swift
//  MemoryGame
//
//  Created by Isis Silva on 11/26/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var game: EmojiMemoryGame
  @Namespace var dealingNamespace
  @State var dealt = Set<Int>()
  
  var body: some View {
    ZStack(alignment: .bottom) {
      VStack {
        gameBody
        deckBody
        
        HStack {
          shuffleButton
          Spacer()
          restartButton
        }
      }
    }
    .padding()
    .ignoresSafeArea(edges: .bottom)
  }
}

private extension ContentView {
  var gameBody: some View {
    AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
      if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
        Color.clear
      } else {
        CardView(card: card)
          .matchedGeometryEffect(id: card.id, in: dealingNamespace)
          .padding(4)
          .transition(.asymmetric(insertion: .identity, removal: .opacity))
          .zIndex(zIndex(of: card))
          .onTapGesture {
            withAnimation {
              game.choose(card: card)
            }
          }
      }
    }
  }
  
  var deckBody: some View {
    ZStack {
      ForEach(game.cards.filter(isUndealt)) { card in
        CardView(card: card)
          .matchedGeometryEffect(id: card.id, in: dealingNamespace)
          .transition(.asymmetric(insertion: .opacity, removal: .identity))
          .zIndex(zIndex(of: card))
      }
    }
    .frame(width: DrawingConstants.undealWidth, height: DrawingConstants.undealHeight)
    .foregroundColor(.orange)
    .onTapGesture {
      for card in game.cards {
        withAnimation(dealAnimation(for: card)) {
          deal(card)
        }
      }
    }
  }
  
  var shuffleButton: some View {
    RoundedButton(title: "Shuffle") {
      withAnimation {
        game.shuffleElements()
      }
    }
  }
  
  var restartButton: some View {
    RoundedButton(title: "Restart") {
      withAnimation {
        dealt = []
        game.restart()
      }
    }
  }
  
  func deal(_ card: MemoryGame<String>.Card) {
    dealt.insert(card.id)
  }
  
  func isUndealt(_ card: MemoryGame<String>.Card) -> Bool {
    !dealt.contains(card.id)
  }
  
  func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
    var delay = 0.0
    if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
      delay = Double(index) * (DrawingConstants.animationDuration / Double(game.cards.count))
    }
    return .easeInOut(duration: DrawingConstants.animationDuration).delay(delay)
  }
  
  func zIndex(of card: EmojiMemoryGame.Card) -> Double {
    -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
  }
  
  enum DrawingConstants {
    static let animationDuration: Double = 1
    static let undealWidth: Double = 68
    static let undealHeight: Double = 100
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(game: EmojiMemoryGame())
  }
}
