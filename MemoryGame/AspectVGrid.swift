//
//  AspectVGrid.swift
//  MemoryGame
//
//  Created by Isis Silva on 12/2/22.
//

import SwiftUI

struct AspectVGrid<Item, SomeItem>: View where Item: Identifiable, SomeItem: View {
  let items: [Item]
  let aspectRatio: CGFloat
  let content: (Item) -> SomeItem
  
  init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> SomeItem) {
    self.items = items
    self.aspectRatio = aspectRatio
    self.content = content
  }
  
    var body: some View {
      GeometryReader { geometry in
        LazyVGrid(columns: [GridItem(.adaptive(minimum: minWidth(size: geometry.size)),spacing:  4)]) {
          ForEach(items) { item in
            content(item).aspectRatio(aspectRatio, contentMode: .fit)
          }
        }
      }
    }
  
  func minWidth(size: CGSize) -> CGFloat {
    let screanArea = size.width * size.height
    let cardArea = Int(screanArea/CGFloat(items.count)*0.6)
    let cardWidth = sqrt(Double(cardArea)*(2/3))
    
    return cardWidth.rounded(.down)
  }
}
