//
//  EncodeHash.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

struct EncodeHashCategoryView: KeyboardCategoryView {
  let insertText: (String) -> Void

  var body: some View {
    List {
      Base64View(insertText: insertText)
      SHA256View(insertText: insertText)
      SHA1View(insertText: insertText)
      MD5View(insertText: insertText)
      CRC32View(insertText: insertText)
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }
}
