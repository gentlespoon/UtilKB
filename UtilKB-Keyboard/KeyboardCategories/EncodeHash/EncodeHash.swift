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
      base64View
      sha256View
      sha1View
      md5View
      crc32View
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }

  // MARK: Base64

  @State var base64EncodeInput: String = ""
  @State var base64DecodeInput: String = ""

  @State var base64EncodeOutput: String = ""
  @State var base64DecodeOutput: String = ""

  var base64View: some View {
    DisclosureGroup("Encode - Base64") {
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

  // MARK: SHA-256

  @State var sha256Input: String = ""
  @State var sha256Output: String = ""

  var sha256View: some View {
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

  // MARK: SHA-1

  @State var sha1Input: String = ""
  @State var sha1Output: String = ""

  var sha1View: some View {
    DisclosureGroup("Hash - SHA-1") {
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

  // MARK: MD5

  @State var md5Input: String = ""
  @State var md5Output: String = ""

  var md5View: some View {
    DisclosureGroup("Hash - MD5") {
      VStack(alignment: .leading) {
        HStack {
          TextField("Plain text", text: $md5Input)
            .onChange(of: md5Input) {
              md5Output = md5Input.md5()
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

  // MARK: CRC32

  @State var crc32Input: String = ""
  @State var crc32Output: String = ""

  var crc32View: some View {
    DisclosureGroup("Hash - CRC32") {
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
