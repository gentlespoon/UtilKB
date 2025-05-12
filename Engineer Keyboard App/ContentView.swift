  //
  //  ContentView.swift
  //  com.angdasoft.engrkb
  //
  //  Created by An So on 2025-05-11.
  //

import SwiftUI

struct ContentView: View {
  
  @State private var testText: String = ""
  var body: some View {
    VStack {
      ZStack(alignment: .leading) {
        if testText == "" {
          Text("Keyboard Test Area...")
        }
        TextEditor(text: $testText)
          .frame(width: 300, height: 100)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(lineWidth: 1)
          )
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
