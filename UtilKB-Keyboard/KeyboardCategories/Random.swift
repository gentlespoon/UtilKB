//
//  Random.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI


enum UUIDv4Case: String, CaseIterable {
  case upper = "UPPER"
  case lower = "lower"
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
        HStack {
          Text("Letter Case")
          Spacer()
          Picker("", selection: $settings.uuidv4Case) {
            ForEach(UUIDv4Case.allCases, id: \.self) { s in
              Text(s.rawValue)
            }
          }
          .pickerStyle(.segmented)
          .fixedSize()
        }
      }
    } label: {
      HStack {
        Text("UUID")
        Spacer()
        Button("v4") {
          insertText(generateUUIDv4())
        }
      }
    }
  }
}
