//
//  BaseX.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

struct BaseXCategoryView: KeyboardCategoryView {
  let insertText: (String) -> Void

  var body: some View {
    List {
      Base2View(insertText: insertText)
      Base64View(insertText: insertText)
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }
}
