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
  case dummy = "Dummy Data"
  case encodeDecode = "Encode & Decode"
  case random = "Random"
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
    .buttonStyle(.bordered)
    .frame(maxWidth: .infinity, minHeight: 280, maxHeight: 400)
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
      Button("\(Image(systemName: "list.bullet"))") {
        activeCategory = .none
      }
      .foregroundStyle(activeCategory == .none ? Color.gray : Color.primary)
      .disabled(activeCategory == .none)
      Button(action: { insertText(" ") }) {
        Text("space").frame(minWidth: 0, maxWidth: .infinity)
      }
      .foregroundStyle(.foreground)
      Button(action: { insertText("[undo]") }) {
        Text("\(Image(systemName: "arrow.uturn.backward"))")
          .foregroundStyle(.red)
      }
      .tint(.red)
      Button(action: { insertText("[delete]") }) {
        Text("\(Image(systemName: "delete.left"))")
          .foregroundStyle(.red)
      }
      .tint(.red)
      Button("return") { insertText("\n") }
        .foregroundStyle(.foreground)
    }
    .frame(maxWidth: .infinity)
    .frame(height: 44)
    .padding(5)
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
      if activeCategory == .dummy {
        DummyDataCategoryView(insertText: insertText)
      }
    }
    .padding([.top, .bottom], 1)
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
    .foregroundStyle(.primary)
    .listStyle(.plain)
  }
}
