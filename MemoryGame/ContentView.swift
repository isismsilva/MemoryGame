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
      if game.isUndealt(card) || (card.isMatched && !card.isFaceUp) {
        Color.clear
      } else {
        CardView(card: card)
          .matchedGeometryEffect(id: card.id, in: dealingNamespace)
          .padding(4)
          .transition(.asymmetric(insertion: .identity, removal: .opacity))
          .zIndex(game.zIndex(of: card))
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
      ForEach(game.cards.filter(game.isUndealt)) { card in
        CardView(card: card)
          .matchedGeometryEffect(id: card.id, in: dealingNamespace)
          .transition(.asymmetric(insertion: .opacity, removal: .identity))
          .zIndex(game.zIndex(of: card))
      }
    }
    .frame(width: DrawingConstants.undealWidth, height: DrawingConstants.undealHeight)
    .foregroundColor(.orange)
    .onTapGesture {
      for card in game.cards {
        withAnimation(game.dealAnimation(for: card)) {
          game.deal(card)
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
        game.restart()
      }
    }
  }
  
  enum DrawingConstants {
    static let undealWidth: Double = 68
    static let undealHeight: Double = 100
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(game: EmojiMemoryGame())
  }
}
