//
//  Card+ViewModifier.swift
//  MemoryGame
//
//  Created by Isis Silva on 12/3/22.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {

  init(isFaceUp: Bool) {
    rotation = isFaceUp ? 180 : 0
  }
  
  var animatableData: Double {
    get { rotation }
    set { rotation = newValue }
  }
  
  var rotation: Double
  
  func body(content: Content) -> some View {
    let shape =  RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
    
    ZStack {
      if rotation > 90 {
        shape.fill(.white)
        shape.strokeBorder(.orange, lineWidth: DrawingConstants.lineWidth)
      } else {
        shape.fill(Color.orange)
      }
      content.opacity(rotation > 90 ? 1 : 0)
    }
    .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
  }
  
  private enum DrawingConstants {
    static let lineWidth: CGFloat = 2
    static let cornerRadius: CGFloat = 10
  }
}

extension View {
  
  func cardify(isFaceUp: Bool) -> some View {
    return self.modifier(Cardify(isFaceUp: isFaceUp))
  }
}
