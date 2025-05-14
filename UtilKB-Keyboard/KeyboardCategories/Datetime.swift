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
        HStack {
          Text("Accuracy")
          Spacer()
          Picker("", selection: $settings.epochSeconds) {
            ForEach(EpochSeconds.allCases, id: \.self) { s in
              Text(s.rawValue)
            }
          }
          .pickerStyle(.segmented)
          .fixedSize()
        }
      }
    } label: {
      HStack {
        Text("Epoch Unix Timestamp")
        Spacer()
        Button(generateEpochString()) {
          insertText(generateEpochString())
        }
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
      if settings.iso8601tz != .local && settings.iso8601os == .z {
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
        HStack {
          Text("Timezone")
          Spacer()
          Picker("", selection: $settings.iso8601tz) {
            ForEach(ISO8601Timezone.allCases, id: \.self) { s in
              Text(s.rawValue)
            }
          }
          .pickerStyle(.segmented)
          .fixedSize()
        }
        HStack {
          Text("Format")
          Spacer()
          Picker("", selection: $settings.iso8601format) {
            ForEach(ISO8601Format.allCases, id: \.self) { s in
              Text(s.rawValue)
            }
          }
          .pickerStyle(.segmented)
          .fixedSize()
        }
        if settings.iso8601format == .simple {
          HStack {
            Text("Accuracy")
            Spacer()
            Picker("", selection: $settings.iso8601s) {
              ForEach(ISO8601Seconds.allCases, id: \.self) { s in
                Text(s.rawValue)
              }
            }
            .pickerStyle(.segmented)
            .fixedSize()
          }
          if settings.iso8601tz == .utc {
            HStack {
              Text("Offset notation")
              Spacer()
              Picker("", selection: $settings.iso8601os) {
                ForEach(ISO8601Offset.allCases, id: \.self) { s in
                  Text(s.rawValue)
                }
              }
              .pickerStyle(.segmented)
              .fixedSize()
            }
          }
        } else {
          HStack {
            Text("Format")
            TextField("yyyy-MM-dd'T'HH:mm:ss.SSSZ", text: $settings.iso8601customFormat)
          }
          Text("Paste a Swift DateFormatter string here.").font(.caption)
        }
      }
    } label: {
      HStack {
        Text("ISO 8601")
        Spacer()
        Button(generateISO8601String()) {
          insertText(generateISO8601String())
        }
      }
    }
  }

  // MARK: URL-friendly Date Time

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
        HStack {
          Text("Format")
          TextField("yyyy-MM-dd'T'HH-mm-ss'Z'", text: $urlFriendlyCustomFormat)
        }
        Text("Pastes a Swift DateFormatter string here.").font(.caption)
      }
    } label: {
      HStack {
        Text("DateTime String")
        Spacer()
        Button(generateDateTimeString(format: urlFriendlyCustomFormat, timezone: .utc)) {
          insertText(generateDateTimeString(format: urlFriendlyCustomFormat, timezone: .utc))
        }
      }
    }
  }

  // MARK: Date Time

  @State var customDateFormat: String = "yyyy-MM-dd"
  @State var customTimeFormat: String = "HH:mm:ss"

  var datetimeView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        HStack {
          Text("Date format")
          TextField("Date format", text: $customDateFormat)
        }
        HStack {
          Text("Time format")
          TextField("Time format", text: $customTimeFormat)
        }
        Text("Pastes a Swift DateFormatter string here.")
          .font(.caption)
      }
    } label: {
      HStack {
        HStack {
          Text("Date & Time")
          Spacer()
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
}
