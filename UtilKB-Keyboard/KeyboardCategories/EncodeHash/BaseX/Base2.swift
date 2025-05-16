//
//  Base2.swift
//  UtilKB
//
//  Created by An So on 2025-05-15.
//

import SwiftUI

struct Base2View: KeyboardCategoryView {
  let insertText: (String) -> Void

  @State var base2EncodeInput: String = ""
  @State var base2DecodeInput: String = ""

  @State var base2EncodeOutput: String = ""
  @State var base2DecodeOutput: String = ""

  @State var base2withSpaces: Bool = true
  @State var base2lineWrap: Bool = true
  @State var base2lineWrapGroups: CGFloat = 4

  var body: some View {
    DisclosureGroup("Base2") {
      VStack(alignment: .leading) {

        Text("Encoded as UTF-8 text").font(.caption)
        HStack {
          TextField("Plain text", text: $base2EncodeInput)
            .onChange(of: base2EncodeInput) {
              base2EncodeOutput = encodeBase2(base2EncodeInput)
            }
          Button {
            insertText(encodeBase2(base2EncodeInput))
          } label: {
            Text(base2EncodeInput == "" ? "Encode" : base2EncodeOutput)
              .frame(width: 100)
              .lineLimit(1)
          }
          .disabled(base2EncodeInput == "")
        }
        HStack {
          TextField("Encoded text", text: $base2DecodeInput)
            .onChange(of: base2DecodeInput) {
              base2DecodeOutput = decodeBase2(base2DecodeInput) ?? ""
            }
          Button {
            insertText(base2DecodeOutput)
          } label: {
            Text(
              base2DecodeInput == ""
                ? "Decode"
                : (base2DecodeOutput == "" ? "Invalid base2" : base2DecodeOutput)
            )
            .frame(width: 100)
            .lineLimit(1)
          }
          .disabled(base2DecodeInput == "" || base2DecodeOutput == "")

        }

        Toggle("With spaces", isOn: $base2withSpaces)
        Toggle("Line wrap", isOn: $base2lineWrap)
        if base2lineWrap {
          HStack {
            Text("Groups per line").font(.caption)
            Text("\(Int(base2lineWrapGroups.rounded(.down)))")
              .frame(width: 50)
            Slider(
              value: $base2lineWrapGroups,
              in: 1...12,
              step: 1,
              label: {}
            )
          }
        }
      }
    }
  }

  private func encodeBase2(_ plain: String) -> String {
    let binaryChunks = plain.utf8.map { byte in
      String(byte, radix: 2).padLeft(toLength: 8, with: "0")
    }
    
    if !base2lineWrap {
      return binaryChunks.joined(separator: base2withSpaces ? " " : "")
    }
    
    var lines: [String] = []
    var line: [String] = []
    
    for (i, chunk) in binaryChunks.enumerated() {
      line.append(chunk)
      
      if (i + 1) % Int(base2lineWrapGroups) == 0 {
        lines.append(line.joined(separator: base2withSpaces ? " " : ""))
        line.removeAll()
      }
    }
    
    if !line.isEmpty {
      lines.append(line.joined(separator: base2withSpaces ? " " : ""))
    }
    
    return lines.joined(separator: "\n")
  }

  private func decodeBase2(_ encoded: String) -> String? {
    let spaceRemoved =
      encoded
      .replacingOccurrences(of: " ", with: "")
      .replacingOccurrences(
        of: "\n", with: "")
    // Sanity check: should be multiple of 8
    guard spaceRemoved.count % 8 == 0 else { return nil }

    var bytes: [UInt8] = []
    var index = spaceRemoved.startIndex

    while index < spaceRemoved.endIndex {
      let nextIndex = spaceRemoved.index(index, offsetBy: 8)
      let chunk = String(spaceRemoved[index..<nextIndex])
      guard let byte = UInt8(chunk, radix: 2) else {
        return nil
      }
      bytes.append(byte)
      index = nextIndex
    }

    return String(bytes: bytes, encoding: .utf8)
  }
}
