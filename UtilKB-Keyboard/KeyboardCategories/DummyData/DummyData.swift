//
//  DummyData.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-12.
//

import SwiftUI

struct DummyDataCategoryView: KeyboardCategoryView {
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

  @State var loremIpsumCount: Int = 1

  var loremIpsumView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("Lorem ipsum")
        Divider()
        Stepper(value: $loremIpsumCount, in: 1...10) {
          Text("Paragraphs: \(loremIpsumCount)")
        }
      }
    } label: {
      Button("Lorem ipsum") {
        insertText(generateLoremIpsum(count: loremIpsumCount))
      }
    }
  }

  func generateLoremIpsum(count: Int) -> String {
    let loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    return (0..<count).map { _ in loremIpsum }.joined(separator: "\n\n")
  }

  // MARK: Dummy identity

  @State var dummyIdCountry: DummyIdCountry = .UK
  @State var dummyId: [String: String] = generateDummyIdentity(.UK)

  var dummyIdentityView: some View {
    DisclosureGroup("Dummy Identity and Address") {
      VStack(alignment: .leading) {
        HStack {
          Button("Shuffle data") {
            dummyId = DummyDataCategoryView.generateDummyIdentity(dummyIdCountry)
          }
          Spacer()
          Picker(selection: $dummyIdCountry) {
            ForEach(DummyIdCountry.allCases, id: \.self) { s in
              Text(s.rawValue)
            }
          } label: {
            Text("Country")
          }
          .onChange(of: dummyIdCountry) { oldValue, newValue in
            dummyId = DummyDataCategoryView.generateDummyIdentity(dummyIdCountry)
          }
        }
        Divider()
        HStack {
          Text("First name")
          Spacer()
          Button(dummyId["firstName"]!) {
            insertText(dummyId["firstName"]!)
          }
        }
        HStack {
          Text("Last name")
          Spacer()
          Button(dummyId["lastName"]!) {
            insertText(dummyId["lastName"]!)
          }
        }
        HStack {
          Text("Email")
          Spacer()
          Button(dummyId["email"]!) {
            insertText(dummyId["email"]!)
          }
        }
        HStack {
          Text("Phone number")
          Spacer()
          Button(dummyId["phoneNumber"]!) {
            insertText(dummyId["phoneNumber"]!)
          }
        }
        HStack {
          Text("Street address")
          Spacer()
          Button(dummyId["streetAddress"]!) {
            insertText(dummyId["streetAddress"]!)
          }
        }
        HStack {
          Text("City")
          Spacer()
          Button(dummyId["city"]!) {
            insertText(dummyId["city"]!)
          }
        }
        HStack(alignment: .top) {
          VStack(alignment: .leading) {
            Text("State")
            Text("Province/Region/Area").font(.caption)
          }
          Spacer()
          Button(dummyId["state"]!) {
            insertText(dummyId["state"]!)
          }
        }
        HStack {
          Text("Zip code")
          Spacer()
          Button(dummyId["zipCode"]!) {
            insertText(dummyId["zipCode"]!)
          }
        }
        HStack {
          Text("Country")
          Spacer()
          Button(dummyIdCountry.rawValue) {
            insertText(dummyIdCountry.rawValue)
          }
        }
      }
    }
  }

  static func generateDummyIdentity(_ country: DummyIdCountry) -> [String: String] {
    var dummyId: [String: String] = [:]
    dummyId["firstName"] = dummyIdList[country]!["firstNames"]!.randomElement()!
    dummyId["lastName"] = dummyIdList[country]!["lastNames"]!.randomElement()!
    dummyId["streetAddress"] = dummyIdList[country]!["streetAddresses"]!.randomElement()!
    dummyId["city"] = dummyIdList[country]!["cities"]!.randomElement()!
    dummyId["state"] = dummyIdList[country]!["states"]!.randomElement()!
    dummyId["zipCode"] = dummyIdList[country]!["zipCodes"]!.randomElement()!
    dummyId["phoneNumber"] = dummyIdList[country]!["phoneNumbers"]!.randomElement()!
    dummyId["email"] =
      "\(dummyId["firstName"]!).\(dummyId["lastName"]!).\(Int.random(in: 1..<100))@example.com"
      .lowercased()
    return dummyId
  }
}
