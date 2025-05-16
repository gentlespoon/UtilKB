//
//  SHA1.swift
//  UtilKB
//
//  Created by An So on 2025-05-15.
//

import SwiftUI

struct SHA1View: KeyboardCategoryView {
  let insertText: (String) -> Void

  @State var sha1Input: String = ""
  @State var sha1Output: String = ""

  var body: some View {
    DisclosureGroup("SHA-1") {
      VStack(alignment: .leading) {
        HStack {
          TextField("Plain text", text: $sha1Input)
            .onChange(of: sha1Input) {
              sha1Output = sha1(sha1Input)
            }
          Button {
            insertText(sha1Output)
          } label: {
            Text(sha1Output == "" ? "Hash" : sha1Output)
              .frame(width: 100)
              .lineLimit(1)
          }
          .disabled(sha1Input == "")
        }
      }
    }
  }

  private func sha1(_ input: String) -> String {
    return input.sha1()
  }
}
