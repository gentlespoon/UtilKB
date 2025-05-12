//
//  EncodeDecode.swift
//  com.angdasoft.engrkb
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

struct EncodeDecodeCategoryView: KeyboardCategoryView {
  let insertText: (String) -> Void

  var body: some View {
    List {
      base64View
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }

  // MARK: UUIDv4

  @State var base64PlainString: String = ""
  @State var base64EncodedString: String = ""

  var base64View: some View {
    DisclosureGroup("Base64") {
      VStack(alignment: .leading) {
        HStack {
          TextField("Plain text", text: $base64PlainString)
          Button {
            insertText(encodeBase64(base64PlainString))
          } label: {
            Text(base64PlainString == "" ? "Encode" : encodeBase64(base64PlainString))
              .frame(width: 100)
              .lineLimit(1)
          }
        }
        HStack {
          TextField("Encoded text", text: $base64EncodedString)
          Button {
            if let decoded = decodeBase64(base64EncodedString) {
              insertText(decoded)
            }
          } label: {
            Text(base64EncodedString == "" ? "Decode" : decodeBase64(base64EncodedString) ?? "Invalid base64")
              .frame(width: 100)
              .lineLimit(1)
          }
        }
      }
    }
  }

  private func encodeBase64(_ plain: String) -> String {
    return plain.data(using: .utf8)!.base64EncodedString()
  }

  private func decodeBase64(_ encoded: String) -> String? {
    guard let data = Data(base64Encoded: encoded) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }
}
