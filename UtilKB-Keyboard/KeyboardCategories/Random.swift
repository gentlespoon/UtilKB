//
//  Random.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI


enum UUIDv4Case: String, CaseIterable {
  case upper = "UPPERCASE"
  case lower = "lowercase"
}

struct RandomCategoryView: KeyboardCategoryView {
  @StateObject private var settings = KeyboardSettings.shared
  let insertText: (String) -> Void

  var body: some View {
    List {
      uuidv4View
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }
  
  // MARK: UUIDv4

  func generateUUIDv4() -> String {
    var uuidString = UUID().uuidString
    if settings.uuidv4Case == .lower {
      uuidString = uuidString.lowercased()
    }
    return uuidString
  }

  var uuidv4View: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("UUID v4")
        Divider()
        Picker(selection: $settings.uuidv4Case) {
          ForEach(UUIDv4Case.allCases, id: \.self) { s in
            Text(s.rawValue)
          }
        } label: {
          Text("Letter case")
        }
      }
    } label: {
      Button("UUID v4") {
        insertText(generateUUIDv4())
      }
    }
  }
}
