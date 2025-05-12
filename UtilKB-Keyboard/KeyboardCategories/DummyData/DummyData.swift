//
//  DummyData.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-12.
//

import SwiftUI

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
        Text("Lorem ipsum")
        Divider()
        Stepper(value: $settings.loremIpsumCount, in: 1...10) {
          Text("Paragraphs: \(settings.loremIpsumCount)")
        }
      }
    } label: {
      Button("Lorem ipsum") {
        insertText(generateLoremIpsum(count: settings.loremIpsumCount))
      }
    }
  }

  func generateLoremIpsum(count: Int) -> String {
    let loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    return (0..<count).map { _ in loremIpsum }.joined(separator: "\n\n")
  }

  // MARK: Dummy identity

  @State var dummyId = [(String, String)]()

  var dummyIdentityView: some View {
    DisclosureGroup("Dummy Identity and Address") {
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
        Button("Shuffle data") {
          dummyId = DummyDataCategoryView.generateDummyIdentity(settings.dummyIdCountry)
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
    }
    .onAppear {
      dummyId = DummyDataCategoryView.generateDummyIdentity(settings.dummyIdCountry)
    }
  }

  static func interpolate(template: String, replacements: [String: () -> String]) -> String {
    let pattern = #"\{(\w+)\}"#
    let regex = try! NSRegularExpression(pattern: pattern, options: [])

    var result = template
    print("Template: \(template)")  // Debug print
    let matches = regex.matches(in: result, range: NSRange(result.startIndex..., in: result))
      .reversed()
    print("Found \(matches.count) matches")  // Debug print

    for match in matches {
      if let range = Range(match.range(at: 0), in: result),
        let keyRange = Range(match.range(at: 1), in: result)
      {
        let key = String(result[keyRange])
        print("Found key: \(key)")  // Debug print
        if let replacement = replacements[key] {
          let newValue = replacement()
          print("Replacing with: \(newValue)")  // Debug print
          result.replaceSubrange(range, with: newValue)
        }
      }
    }

    print("Final result: \(result)")  // Debug print
    return result
  }

  static func generateDummyIdentity(_ country: DummyIdCountry) -> [(String, String)] {
    var result: [(String, String)] = []

    // Generate personal information
    for (field, displayName) in piiFormats(country) {
      if field == "email" {
        continue
      }
      if let value = dummyIdList[country]?[field]?.randomElement() {
        result.append((displayName, value))
      }
    }
    // Generate email
    if let givenName = result.first(where: {
      $0.0 == piiFormats(country).first(where: { $0.0 == "givenname" })?.1
    })?.1,
      let surname = result.first(where: {
        $0.0 == piiFormats(country).first(where: { $0.0 == "surname" })?.1
      })?.1
    {
      let email = "\(givenName).\(surname).\(Int.random(in: 1..<100))@example.com".lowercased()
      result.append((piiFormats(country).first(where: { $0.0 == "email" })?.1 ?? "Email", email))
    }

    // Generate address fields based on country format
    for (field, displayName) in countryAddressFormats(country) {
      if var value = dummyIdList[country]?[field]?.randomElement() {
        if field == "street" {
          value = interpolate(
            template: value,
            replacements: [
              "number": { String(Int.random(in: 1...999)) }
            ])
        }
        result.append((displayName, value))
      }
    }

    return result
  }
}
