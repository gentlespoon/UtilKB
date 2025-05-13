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
  case encodeHash = "Encode & Hash"
  case random = "Random"
}

struct KeyboardView: View {
  let insertText: (String) -> Void
  @StateObject private var settings = KeyboardSettings.shared
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
  }

  var controlBar: some View {
    HStack(spacing: 8) {
      Button("\(Image(systemName: "list.bullet"))") {
        settings.activeCategory = .none
      }
      .foregroundStyle(settings.activeCategory == .none ? Color.gray : Color.primary)
      .disabled(settings.activeCategory == .none)
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
      if settings.activeCategory == .none {
        kbCategorySelector
      }
      if settings.activeCategory == .datetime {
        DatetimeCategoryView(insertText: insertText)
      }
      if settings.activeCategory == .random {
        RandomCategoryView(insertText: insertText)
      }
      if settings.activeCategory == .encodeHash {
        EncodeHashCategoryView(insertText: insertText)
      }
      if settings.activeCategory == .dummy {
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
            settings.activeCategory = category
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
