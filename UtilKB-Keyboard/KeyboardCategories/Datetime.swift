//
//  Datetime.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

enum EpochSeconds: String, CaseIterable {
  case s = "s"
  case ms = "ms"
}

enum ISO8601Timezone: String, CaseIterable {
  case utc = "UTC"
  case local = "local"
}

enum ISO8601Format: String, CaseIterable {
  case simple = "Simple"
  case custom = "Custom"
}

enum ISO8601Offset: String, CaseIterable {
  case p0000 = "+0000"
  case z = "Z"
}

enum ISO8601Seconds: String, CaseIterable {
  case s = "s"
  case ms = "ms"
}


struct DatetimeCategoryView: KeyboardCategoryView {
  @StateObject private var settings = KeyboardSettings.shared
  let insertText: (String) -> Void
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    List {
      datetimeView
      epochView
      isoView
      urlFriendlyDateView
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }

  func isValidDateFormat(_ format: String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: format) != nil
  }

  // MARK: Epoch

  func generateEpochString() -> String {
    return String(
      Int(
        Date()
          .timeIntervalSince1970 * (settings.epochSeconds == .ms ? 1000 : 1)))
  }

  var epochView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("Epoch Unix Timestamp")
        Divider()
        Picker(selection: $settings.epochSeconds) {
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

  
  // MARK: ISO 8601 Date Time
  
  func generateISO8601String() -> String {
    let formatter = DateFormatter()
    var format = ""
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = settings.iso8601tz == .utc ? TimeZone(identifier: "UTC") : TimeZone.current
    if settings.iso8601format == .simple {
      format = "yyyy-MM-dd'T'HH:mm:ss"
      if settings.iso8601s == .ms {
        format += ".SSS"
      }
      if settings.iso8601os == .z {
        format += "'Z'"
      } else {
        format += "Z"
      }
    } else {
      format = settings.iso8601customFormat
    }
    formatter.dateFormat = format
    return formatter.string(from: Date())
  }

  var isoView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("ISO 8601 / RFC 3339")
        Divider()
        Picker(selection: $settings.iso8601tz) {
          ForEach(ISO8601Timezone.allCases, id: \.self) { s in
            Text(s.rawValue)
          }
        } label: {
          Text("Timezone")
        }
        Picker(selection: $settings.iso8601format) {
          ForEach(ISO8601Format.allCases, id: \.self) { s in
            Text(s.rawValue)
          }
        } label: {
          Text("Format")
        }
        if settings.iso8601format == .simple {
          Picker(selection: $settings.iso8601s) {
            ForEach(ISO8601Seconds.allCases, id: \.self) { s in
              Text(s.rawValue)
            }
          } label: {
            Text("Accuracy")
          }
          if settings.iso8601tz == .utc {
            Picker(selection: $settings.iso8601os) {
              ForEach(ISO8601Offset.allCases, id: \.self) { s in
                Text(s.rawValue)
              }
            } label: {
              Text("Offset notation")
            }
          }
        } else {
          TextField("Custom format", text: $settings.iso8601customFormat)
          Text("Paste a Swift DateFormatter string here.").font(.caption)
        }
      }
    } label: {
      Button(generateISO8601String()) {
        insertText(generateISO8601String())
      }
    }
  }

  // MARK: Date Time

  func generateDateTimeString(format: String, timezone: ISO8601Timezone = .local) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = timezone == .utc ? TimeZone(identifier: "UTC") : TimeZone.current
    formatter.dateFormat = format
    return formatter.string(from: Date())
  }

  @State var urlFriendlyCustomFormat: String = "yyyy-MM-dd'T'HH-mm-ss'Z'"

  var urlFriendlyDateView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("URL-friendly Date Time String")
        Divider()
        TextField("Custom format", text: $urlFriendlyCustomFormat)
        Text("Pastes a Swift DateFormatter string here.").font(.caption)
      }
    } label: {
      Button(generateDateTimeString(format: urlFriendlyCustomFormat, timezone: .utc)) {
        insertText(generateDateTimeString(format: urlFriendlyCustomFormat, timezone: .utc))
      }
    }
  }

  // MARK: Date

  @State var customDateFormat: String = "yyyy-MM-dd"
  @State var customTimeFormat: String = "HH:mm:ss"

  var datetimeView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("Date Time")
        Divider()
        TextField("Custom Date format", text: $customDateFormat)
        TextField("Custom Time format", text: $customTimeFormat)
        Text("Pastes a Swift DateFormatter string here.").font(.caption)
      }
    } label: {
      HStack {
        Button(generateDateTimeString(format: customDateFormat, timezone: .local)) {
          insertText(generateDateTimeString(format: customDateFormat, timezone: .local))
        }
        Button(generateDateTimeString(format: customTimeFormat, timezone: .local)) {
          insertText(generateDateTimeString(format: customTimeFormat, timezone: .local))
        }
      }
    }
  }
}
