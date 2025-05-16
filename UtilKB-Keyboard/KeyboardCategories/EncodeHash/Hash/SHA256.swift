//
//  SHA256.swift
//  UtilKB
//
//  Created by An So on 2025-05-15.
//

import SwiftUI

struct SHA256View: KeyboardCategoryView {
  let insertText: (String) -> Void

  @State var sha256Input: String = ""
  @State var sha256Output: String = ""

  var body: some View {
    DisclosureGroup("Hash - SHA-256") {
      VStack(alignment: .leading) {
        HStack {
          TextField("Plain text", text: $sha256Input)
            .onChange(of: sha256Input) {
              sha256Output = sha256(sha256Input)
            }
          Button {
            insertText(sha256Output)
          } label: {
            Text(sha256Output == "" ? "Hash" : sha256Output)
              .frame(width: 100)
              .lineLimit(1)
          }
          .disabled(sha256Input == "")
        }
      }
    }
  }

  private func sha256(_ input: String) -> String {
    return input.sha256()
  }
}
