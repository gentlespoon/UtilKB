//
//  Random.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

struct RandomCategoryView: KeyboardCategoryView {
  let insertText: (String) -> Void

  var body: some View {
    List {
      uuidv4View
      loremIpsumView
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }

  // MARK: UUIDv4

  enum UUIDv4Case: String, CaseIterable {
    case upper = "UPPERCASE"
    case lower = "lowercase"
  }

  @State var uuidv4Case: UUIDv4Case = .upper

  func generateUUIDv4() -> String {
    var uuidString = UUID().uuidString
    if uuidv4Case == .lower {
      uuidString = uuidString.lowercased()
    }
    return uuidString
  }

  var uuidv4View: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("Epoch Unix Timestamp")
        Divider()
        Picker(selection: $uuidv4Case) {
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

  // MARK: Lorem ipsum

  @State var loremIpsumCount: Int = 1

  var loremIpsumView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("Lorem ipsum")
        Divider()
        Stepper(value: $loremIpsumCount, in: 1...10) {
          Text("Paragraphs: \(loremIpsumCount)")
        }
      }
    } label: {
      Button("Lorem ipsum") {
        insertText(generateLoremIpsum(count: loremIpsumCount))
      }
    }
  }

  func generateLoremIpsum(count: Int) -> String {
    let loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    return (0..<count).map { _ in loremIpsum }.joined(separator: "\n\n")
  }
}
