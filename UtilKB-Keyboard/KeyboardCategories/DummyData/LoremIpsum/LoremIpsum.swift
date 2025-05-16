//
//  LoremIpsum.swift
//  UtilKB
//
//  Created by An So on 2025-05-15.
//

import SwiftUI

enum LoremIpsumMode: String, CaseIterable {
  case word = "Word"
  case sentence = "Sentence"
  case paragraph = "Paragraph"
}

enum LoremIpsumCase: String, CaseIterable {
  case lowercase = "lower case"
  case uppercase = "UPPER CASE"
  case title = "Title Case"
  case sentence = "Sentence case"
}

struct LoremIpsumView: KeyboardCategoryView {
  
  @StateObject private var settings = KeyboardSettings.shared
  let insertText: (String) -> Void
  
  @State private var loremIpsumCase: LoremIpsumCase = .sentence
  @State private var loremIpsumCount: CGFloat = 2
  
  var body: some View {
    DisclosureGroup {
      VStack {
        HStack {
          Spacer()
          Button("Word") {
            insertText(generateLoremIpsum(mode: .word))
          }
          Button("Sentence") {
            insertText(generateLoremIpsum(mode: .sentence))
          }
          Button("Paragraph") {
            insertText(generateLoremIpsum(mode: .paragraph))
          }
        }
        .padding([.bottom], 8)
        Picker("", selection: $loremIpsumCase) {
          ForEach(LoremIpsumCase.allCases, id: \.self) { letterCase in
            Text(letterCase.rawValue)
          }
        }
        HStack {
          Text("Count")
          Text("\(Int(loremIpsumCount.rounded(.down)))")
            .frame(width: 50)
          Slider(
            value: $loremIpsumCount,
            in: 1...10,
            step: 1,
            label: {}
          )
        }
      }
    } label: {
      HStack {
        Text("Lorem Ipsum")
      }
    }
  }
  
  func generateLoremIpsum(
    mode: LoremIpsumMode,
    letterCase: LoremIpsumCase? = nil,
    count: Int? = nil
  ) -> String {
    let letterCase = letterCase != nil ? letterCase! : loremIpsumCase
    let count = count != nil ? count! : Int(loremIpsumCount.rounded(.down))
    
    switch mode {
    case .word:
        // Get all words from all paragraphs
      let allWords = loremIpsum.flatMap { $0.components(separatedBy: " ") }
        // Find a random starting point that has enough consecutive words
      let startIndex = Int.random(in: 0...(allWords.count - count))
      let selectedWords = Array(allWords[startIndex..<(startIndex + count)]).map {
        $0.trimmingCharacters(in: .punctuationCharacters)
      }
      let result = selectedWords.joined(separator: " ")
      
      switch letterCase {
      case .lowercase: return result.lowercased()
      case .uppercase: return result.uppercased()
      case .title: return result.capitalized
      case .sentence: return result.prefix(1).uppercased() + result.dropFirst().lowercased()
      }
      
    case .sentence:
        // Get all sentences from all paragraphs
      let allSentences = loremIpsum.flatMap { paragraph in
        paragraph.components(separatedBy: ". ")
          .filter { !$0.isEmpty }
          .map { if $0.last == "." { return $0 } else { return $0 + "."
          } }
      }
        // Randomly select sentences
      var selectedSentences = (0..<count).map { _ in allSentences.randomElement()! }
      selectedSentences = selectedSentences.map {
        let s = $0.trimmingCharacters(in: .whitespacesAndNewlines)
        switch letterCase {
        case .lowercase: return s.lowercased()
        case .uppercase: return s.uppercased()
        case .title: return s.capitalized
        case .sentence: return s.prefix(1).uppercased() + s.dropFirst().lowercased()
        }
      }
      let result = selectedSentences.joined(separator: " ")
      return result
      
    case .paragraph:
        // Randomly select paragraphs
      var paragraphs: [String] = []
      for _ in 0..<count {
        let randomParagraph = generateLoremIpsum(mode: .sentence, count: Int.random(in: 3...5))
        paragraphs.append(randomParagraph)
      }
      return paragraphs.joined(separator: "\n\n") + "\n"
    }
  }
}
