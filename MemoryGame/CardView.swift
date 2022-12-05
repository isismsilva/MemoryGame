//
//  CardView.swift
//  MemoryGame
//
//  Created by Isis Silva on 12/4/22.
//

import SwiftUI

struct CardView: View {
  let card: EmojiMemoryGame.Card
  let shape =  RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
  
  var body: some View {
    GeometryReader { geomtry in
      ZStack {
        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90), clockwise: true)
          .padding(4)
          .foregroundColor(.orange)
          .opacity(0.5)
        Text(card.content)
          .font(.system(size: DrawingConstants.fontSize))
          .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
          .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
          .scaleEffect(scale(thatFits: geomtry.size))
      }
      .cardify(isFaceUp: card.isFaceUp)
    }
  }
  
  private func scale(thatFits size: CGSize) -> CGFloat {
    min(size.width, size.height) / (DrawingConstants.fontSize/DrawingConstants.fontScale)
  }
  
  private enum DrawingConstants {
    static let fontScale: CGFloat = 0.8
    static let fontSize: CGFloat = 32
    static let lineWidth: CGFloat = 2
    static let cornerRadius: CGFloat = 20
    static let opacity: CGFloat = 0
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: EmojiMemoryGame.Card(id: 0, isFaceUp: true, content: "🏄🏻‍♀️"))
      .padding()
  }
}
