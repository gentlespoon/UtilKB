//
//  Random.swift
//  com.angdasoft.engrkb
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

struct RandomCategoryView: KeyboardCategoryView {
  let insertText: (String) -> Void

  var body: some View {
    List {
      uuidv4View
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
}

