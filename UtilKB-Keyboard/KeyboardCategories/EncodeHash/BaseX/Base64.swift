//
//  Base64.swift
//  UtilKB
//
//  Created by An So on 2025-05-15.
//

import SwiftUI

struct Base64View: KeyboardCategoryView {
  let insertText: (String) -> Void
  
  @State var base64EncodeInput: String = ""
  @State var base64DecodeInput: String = ""
  
  @State var base64EncodeOutput: String = ""
  @State var base64DecodeOutput: String = ""
  
  var body: some View {
    DisclosureGroup("Base64") {
      VStack(alignment: .leading) {
        HStack {
          TextField("Plain text", text: $base64EncodeInput)
            .onChange(of: base64EncodeInput) {
              base64EncodeOutput = encodeBase64(base64EncodeInput)
            }
          Button {
            insertText(base64EncodeOutput)
          } label: {
            Text(base64EncodeInput == "" ? "Encode" : base64EncodeOutput)
              .frame(width: 100)
              .lineLimit(1)
          }
          .disabled(base64EncodeInput == "")
        }
        HStack {
          TextField("Encoded text", text: $base64DecodeInput)
            .onChange(of: base64DecodeInput) {
              base64DecodeOutput = decodeBase64(base64DecodeInput) ?? ""
            }
          Button {
            insertText(base64DecodeOutput)
          } label: {
            Text(
              base64DecodeInput == ""
              ? "Decode"
              : (base64DecodeOutput == "" ? "Invalid base64" : base64DecodeOutput)
            )
            .frame(width: 100)
            .lineLimit(1)
          }
          .disabled(base64DecodeInput == "" || base64DecodeOutput == "")
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
