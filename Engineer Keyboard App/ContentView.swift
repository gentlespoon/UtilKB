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
      Text("Keyboard Test Area")
      TextEditor(text: $testText)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(lineWidth: 1)
        )
    }
    .padding(20)
  }
}

#Preview {
  ContentView()
}
