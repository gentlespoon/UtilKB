//
//  MD5.swift
//  UtilKB
//
//  Created by An So on 2025-05-15.
//

import SwiftUI

struct MD5View: KeyboardCategoryView {
  let insertText: (String) -> Void

  @State var md5Input: String = ""
  @State var md5Output: String = ""

  var body: some View {
    DisclosureGroup("MD5") {
      VStack(alignment: .leading) {
        HStack {
          TextField("Plain text", text: $md5Input)
            .onChange(of: md5Input) {
              md5Output = md5(md5Input)
            }
          Button {
            insertText(md5Output)
          } label: {
            Text(md5Output == "" ? "Hash" : md5Output)
              .frame(width: 100)
              .lineLimit(1)
          }
          .disabled(md5Input == "")
        }
      }
    }
  }

  private func md5(_ input: String) -> String {
    return input.md5()
  }
}
