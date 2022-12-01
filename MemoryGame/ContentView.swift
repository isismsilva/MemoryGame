//
//  ContentView.swift
//  MemoryGame
//
//  Created by Isis Silva on 11/26/22.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var model: EmojiMemoryGame
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], spacing: 4) {
          
          ForEach(model.cards, id: \.id) { card in
            CardView(card: card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                model.choose(card: card)
              }
          }
        }
      }
    }
    .padding()
  }
}

struct CardView: View {
  let card: EmojiMemoryGame.card
  let shape =  RoundedRectangle(cornerRadius: 20)
  
  var body: some View {
    GeometryReader { geomtry in
      ZStack {
        if card.isFaceUp {
          shape.fill(.white)
          shape.strokeBorder(.orange, lineWidth: 2)
          Text(card.content).font(Font.system(size: .maximum(geomtry.size.width, geomtry.size.height)))
        } else if card.isMatched {
          shape.opacity(0)
        } else {
          shape.fill(Color.orange)
        }
      }
      
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(model: EmojiMemoryGame())
  }
}
