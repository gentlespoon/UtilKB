//
//  CRC32.swift
//  UtilKB
//
//  Created by An So on 2025-05-15.
//

import SwiftUI

struct CRC32View: KeyboardCategoryView {
  let insertText: (String) -> Void

  @State var crc32Input: String = ""
  @State var crc32Output: String = ""

  var body: some View {
    DisclosureGroup("CRC32") {
      VStack(alignment: .leading) {
        HStack {
          TextField("Plain text", text: $crc32Input)
            .onChange(of: crc32Input) {
              crc32Output = crc32(crc32Input)
            }
          Button {
            insertText(crc32Output)
          } label: {
            Text(crc32Output == "" ? "Hash" : crc32Output)
              .frame(width: 100)
              .lineLimit(1)
          }
          .disabled(crc32Input == "")
        }
      }
    }
  }

  private func crc32(_ input: String) -> String {
    return input.crc32()
  }
}
