//
//  KeyboardView.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

enum KeyboardCategory: String, CaseIterable {
  case none = "None"
  case datetime = "Date & Time"
  case random = "Random"
  case encodeDecode = "Encode & Decode"
}

struct KeyboardView: View {
  let insertText: (String) -> Void
  @State var activeCategory: KeyboardCategory = {
    if let savedCategory = UserDefaults.standard.string(forKey: "lastActiveCategory"),
      let category = KeyboardCategory(rawValue: savedCategory)
    {
      return category
    }
    return .none
  }()
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    VStack {
      keyboardBody
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      controlBar
    }
    .padding(5)
    .buttonStyle(.bordered)
    .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 300)
    .background(
      Color(
        hex: colorScheme == .dark
          ? KeyboardContext.backgroundColor.dark.rawValue
          : KeyboardContext.backgroundColor.light.rawValue
      )
      .ignoresSafeArea()
    )
    .onChange(of: activeCategory) { oldCategory, newCategory in
      UserDefaults.standard.set(newCategory.rawValue, forKey: "lastActiveCategory")
    }
  }

  var controlBar: some View {
    HStack(spacing: 8) {
      Button("category") {
        activeCategory = .none
      }
      .disabled(activeCategory == .none)
      Button(action: { insertText(" ") }) {
        Text("space").frame(minWidth: 0, maxWidth: .infinity)
      }
      Button(action: { insertText("") }) {
        Text("del").foregroundStyle(.red)
      }
      .tint(.red)
      Button("return") { insertText("\n") }
    }
    .frame(maxWidth: .infinity)
    .frame(height: 44)
  }

  var keyboardBody: some View {
    VStack {
      if activeCategory == .none {
        kbCategorySelector
      }
      if activeCategory == .datetime {
        DatetimeCategoryView(insertText: insertText)
      }
      if activeCategory == .random {
        RandomCategoryView(insertText: insertText)
      }
      if activeCategory == .encodeDecode {
        EncodeDecodeCategoryView(insertText: insertText)
      }
      Spacer()
    }
  }

  var kbCategorySelector: some View {
    List {
      ForEach(KeyboardCategory.allCases, id: \.self) { category in
        if category == .none {
          EmptyView()
        } else {
          Button {
            activeCategory = category
          } label: {
            HStack {
              Text(category.rawValue)
              Spacer()
            }
          }
        }
      }
    }
    .buttonStyle(.borderless)
    .listStyle(.plain)
  }
}
