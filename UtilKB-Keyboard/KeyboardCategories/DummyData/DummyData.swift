//
//  DummyData.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-12.
//

import SwiftUI
import UIKit

struct DummyDataCategoryView: KeyboardCategoryView {
  @StateObject private var settings = KeyboardSettings.shared
  let insertText: (String) -> Void

  var body: some View {
    List {
      loremIpsumView
      dummyIdentityView
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }

  // MARK: Lorem ipsum

  var loremIpsumView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Stepper(value: $settings.loremIpsumCount, in: 1...10) {
          Text("Paragraphs: \(settings.loremIpsumCount)")
        }
      }
    } label: {
      HStack {
        Text("Placeholder Text")
        Spacer()
        Button("Lorem ipsum") {
          insertText(generateLoremIpsum(count: settings.loremIpsumCount))
        }
      }
    }
  }

  func generateLoremIpsum(count: Int) -> String {

    // Always start with the first paragraph
    var paragraphs = [loremIpsum[0]]

    // Add random paragraphs from the rest
    if count > 1 {
      let remainingParagraphs = Array(loremIpsum.dropFirst())
      paragraphs.append(contentsOf: (1..<count).map { _ in remainingParagraphs.randomElement()! })
    }

    return paragraphs.joined(separator: "\n\n")
  }

  // MARK: Dummy identity

  @State var dummyId = [(String, String)]()

  var dummyIdentityView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        HStack {
          Picker(selection: $settings.dummyIdCountry) {
            ForEach(DummyIdCountry.allCases, id: \.self) { country in
              Text(country.rawValue)
            }
          } label: {
              Text("Country")
          }
          .onChange(of: settings.dummyIdCountry) { oldValue, newValue in
            dummyId = DummyDataCategoryView.generateDummyIdentity(settings.dummyIdCountry)
          }
        }

        Divider()
        if dummyId.count > 0 {
          ForEach(dummyId.indices, id: \.self) { index in
            HStack {
              Text(dummyId[index].0)
              Spacer()
              Button(dummyId[index].1) {
                insertText(dummyId[index].1)
              }
            }
          }
        }
      }
    } label: {
      HStack {
        Text("Dummy Name and Address")
        Spacer()
        Button("\(Image(systemName: "arrow.clockwise"))") {
          dummyId = DummyDataCategoryView.generateDummyIdentity(settings.dummyIdCountry)
        }
      }
    }
    .onAppear {
      dummyId = DummyDataCategoryView.generateDummyIdentity(settings.dummyIdCountry)
    }
  }

  static func interpolate(template: String, replacements: [String: () -> String]) -> String {
    let pattern = #"\{(\w+)\}"#
    let regex = try! NSRegularExpression(pattern: pattern, options: [])

    var result = template
    let matches = regex.matches(in: result, range: NSRange(result.startIndex..., in: result))
      .reversed()

    for match in matches {
      if let range = Range(match.range(at: 0), in: result),
        let keyRange = Range(match.range(at: 1), in: result)
      {
        let key = String(result[keyRange])
        if let replacement = replacements[key] {
          let newValue = replacement()
          result.replaceSubrange(range, with: newValue)
        }
      }
    }

    return result
  }

  static func transliterateToASCII(_ input: String, languageHint: DummyIdCountry? = nil) -> String {
    let mutable = NSMutableString(string: input) as CFMutableString

    // handle script-specific transformation
    switch languageHint {
    case .CN:
      CFStringTransform(mutable, nil, kCFStringTransformToLatin, false)
    case .JP:
      return input
    case .RU:
      CFStringTransform(mutable, nil, kCFStringTransformToLatin, false)
    default:
      // Default: Try transliterating
      CFStringTransform(mutable, nil, kCFStringTransformToLatin, false)
    }

    // strip diacritics
    CFStringTransform(mutable, nil, kCFStringTransformStripCombiningMarks, false)

    // keep only A-Z and a-z characters
    let asciiOnly = (mutable as String)
      .filter { $0.isASCII && $0.isLetter }

    return asciiOnly.lowercased()
  }

  static func generateDummyIdentity(_ country: DummyIdCountry) -> [(String, String)] {
    var result: [(String, String)] = []

    // Get random indices for consistent address components
    let cityIndex = Int.random(in: 0..<(dummyIdList[country]?["city"]?.count ?? 0))

    // Generate name components
    let givenName = dummyIdList[country]?["givenname"]?.randomElement() ?? ""
    let surname = dummyIdList[country]?["surname"]?.randomElement() ?? ""

    // Get phonetic versions for email
    let emailGivenName = DummyDataCategoryView.transliterateToASCII(
      givenName, languageHint: country)
    let emailSurname = DummyDataCategoryView.transliterateToASCII(surname, languageHint: country)

    // Add PII fields
    for (key, label) in piiFormats(country) {
      switch key {
      case "givenname":
        result.append((label, givenName))
      case "surname":
        result.append((label, surname))
      case "phone":
        if let phone = dummyIdList[country]?["phone"]?.randomElement() {
          result.append((label, phone))
        }
      case "email":
        let email = "\(emailGivenName).\(emailSurname).\(Int.random(in: 1..<100))@example.com"
          .lowercased()
        result.append((label, email))
      default:
        break
      }
    }

    // Add address fields
    for (key, label) in countryAddressFormats(country) {
      switch key {
      case "street":
        if let street = dummyIdList[country]?["street"]?.randomElement() {
          let streetWithNumbers = interpolate(
            template: street,
            replacements: [
              "number": { String(Int.random(in: 1...999)) }
            ])
          result.append((label, streetWithNumbers))
        }
      case "city":
        if let city = dummyIdList[country]?["city"]?[cityIndex] {
          result.append((label, city))
        }
      case "state", "province", "prefecture", "region":
        if let state = dummyIdList[country]?[key]?[cityIndex] {
          result.append((label, state))
        }
      case "zipCode", "postcode", "postalCode":
        if let code = dummyIdList[country]?[key]?[cityIndex] {
          result.append((label, code))
        }
      default:
        break
      }
    }

    return result
  }
}
