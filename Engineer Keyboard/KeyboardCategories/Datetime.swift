//
//  DatetimeCategoryView.swift
//  Engineer Keyboard
//
//  Created by An So on 2025-05-11.
//

//
//  Datetime.swift
//  com.angdasoft.engrkb
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

struct DatetimeCategoryView: KeyboardCategoryView {
  let insertText: (String) -> Void
  @Environment(\.colorScheme) var colorScheme

  @State var width: CGFloat = .infinity

  var body: some View {
    List {
      epochView
      isoView
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
    .onAppear {
      width = UIScreen.main.bounds.size.width
    }
  }

  // MARK: Epoch

  enum EpochSeconds: String, CaseIterable {
    case s = "s"
    case ms = "ms"
  }

  @State var epochSeconds: EpochSeconds = .s

  func generateEpochString() -> String {
    return String(
      Int(
        Date()
          .timeIntervalSince1970 * (epochSeconds == .ms ? 1000 : 1)))
  }

  var epochView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("Epoch Unix Timestamp")
        Divider()
        Picker(selection: $epochSeconds) {
          ForEach(EpochSeconds.allCases, id: \.self) { s in
            Text(s.rawValue)
          }
        } label: {
          Text("Accuracy")
        }
      }
      
    } label: {
      Button(generateEpochString()) {
        insertText(generateEpochString())
      }
    }
  }

  // MARK: ISO8601
  enum ISO8601Timezone: String, CaseIterable {
    case utc = "UTC"
    case local = "local"
  }

  enum ISO8601Offset: String, CaseIterable {
    case p0000 = "+0000"
    case z = "Z"
  }

  enum ISO8601Seconds: String, CaseIterable {
    case s = "s"
    case ms = "ms"
  }

  @State var iso8601s: ISO8601Seconds = .s
  @State var iso8601tz: ISO8601Timezone = .local
  @State var iso8601os: ISO8601Offset = .p0000

  func generateISO8601String() -> String {
    let formatter = DateFormatter()
    var format = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    if iso8601s == .ms {
      format += ".SSS"
    }
    if iso8601tz == .utc {
      formatter.timeZone = TimeZone(identifier: "UTC")
      if iso8601os == .z {
        format += "'Z'"
      } else {
        format += "Z"
      }
    } else {
      formatter.timeZone = TimeZone.current
      format += "Z"
    }
    formatter.dateFormat = format
    return formatter.string(from: Date())
  }

  var isoView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("ISO 8601 / RFC 3339")
        Divider()
        Picker(selection: $iso8601s) {
          ForEach(ISO8601Seconds.allCases, id: \.self) { s in
            Text(s.rawValue)
          }
        } label: {
          Text("Accuracy")
        }
        Picker(selection: $iso8601tz) {
          ForEach(ISO8601Timezone.allCases, id: \.self) { s in
            Text(s.rawValue)
          }
        } label: {
          Text("Timezone")
        }
        if iso8601tz == .utc {
          Picker(selection: $iso8601os) {
            ForEach(ISO8601Offset.allCases, id: \.self) { s in
              Text(s.rawValue)
            }
          } label: {
            Text("Offset notation")
          }
        }
      }
    } label: {
        Button(generateISO8601String()) {
          insertText(generateISO8601String())
        }
    }
  }
}
