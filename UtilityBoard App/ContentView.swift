//
//  ContentView.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

struct ContentView: View {

  @State private var testText: String = ""
  var body: some View {
    VStack(alignment: .leading) {
      Text("UtilityBoard").font(.largeTitle)
      Text("All-in-one keyboard for developers and power users.").font(.subheadline)
      Spacer()
      Text(
        "Quickly insert timestamps, UUIDs, Base64, Lorem Ipsum, and more with a single tap. Whether you're debugging APIs, filling forms, or testing apps, UtilityBoard saves time and keeps you in flow."
      ).font(.caption)
      Spacer()
      Divider()
      Spacer()
      Text("Don't forget to enable keyboard.").font(.subheadline)
      Text("Full access is required if you use any clipboard-related features like base64 or custom string formatting.").font(.caption)
      Button("Keyboard Settings") {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(settingsUrl)
        }
      }
      Text("Enjoy!")
      Divider()
      Text("Keyboard Testing Area").font(.headline)
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
