//
//  RoundedButton.swift
//  MemoryGame
//
//  Created by Isis Silva on 12/4/22.
//

import SwiftUI

struct RoundedButton: View {
  let title: String
  let content: (() -> Void)
  
  var body: some View {
    Button {
      content()
    } label: {
      Text(title)
        .font(.system(.headline, design: .monospaced).bold())
        .padding().padding(.horizontal)
        .background(.pink)
        .cornerRadius(25)
        .foregroundColor(.white)
    }
  }
}

struct RoundedButton_Previews: PreviewProvider {
  static var previews: some View {
    RoundedButton(title: "Title", content: {})
  }
}
