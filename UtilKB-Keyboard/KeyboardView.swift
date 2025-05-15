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
    VStack(spacing: 0) {
      keyboardBody
      controlBar
    }
    .buttonStyle(.bordered)
    .frame(maxWidth: .infinity, minHeight: settings.keyboardHeight, maxHeight: 500)
    .background(
      Color(
        hex: colorScheme == .dark
          ? KeyboardSettings.backgroundColor.dark.rawValue
          : KeyboardSettings.backgroundColor.light.rawValue
      )
      .ignoresSafeArea()
    )
    .onAppear {
      settings.loadKeyboardHeight()
    }
  }

  let controlBarHeight: CGFloat = 44

  var controlBar: some View {
    HStack(spacing: 8) {
      Button("\(Image(systemName: "list.bullet"))") {
        settings.activeCategory = .none
      }
      .foregroundStyle(settings.activeCategory == .none ? Color.gray : Color.primary)
      .disabled(settings.activeCategory == .none)
      .contextMenu {
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
    .frame(maxHeight: controlBarHeight)
    .padding([.horizontal], 8)
  }

  let keyboardPaddingTop = 2.0

  var keyboardBody: some View {
    ScrollView {
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
      .frame(height: settings.keyboardHeight - controlBarHeight - keyboardPaddingTop)
    }
    .frame(height: settings.keyboardHeight - controlBarHeight - keyboardPaddingTop)
    .padding([.top], keyboardPaddingTop)
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
