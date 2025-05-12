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
      datetimeView
      epochView
      isoView
      urlFriendlyDateView
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
    .onAppear {
      width = UIScreen.main.bounds.size.width
    }
  }
  
  
  
  func isValidDateFormat(_ format: String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: format) != nil
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

  // MARK: ISO 8601 Date Time

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

  @State var iso8601tz: ISO8601Timezone = .local
  @State var iso8601format: ISO8601Format = .simple
  @State var iso8601s: ISO8601Seconds = .s
  @State var iso8601os: ISO8601Offset = .p0000
  @State var iso8601customFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

  func generateISO8601String() -> String {
    let formatter = DateFormatter()
    var format = ""
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = iso8601tz == .utc ? TimeZone(identifier: "UTC") : TimeZone.current
    if iso8601format == .simple {
      format = "yyyy-MM-dd'T'HH:mm:ss"
      if iso8601s == .ms {
        format += ".SSS"
      }
      if iso8601os == .z {
        format += "'Z'"
      } else {
        format += "Z"
      }
    } else {
      format = iso8601customFormat
    }
    formatter.dateFormat = format
    return formatter.string(from: Date())
  }

  var isoView: some View {
    DisclosureGroup {
      VStack(alignment: .leading) {
        Text("ISO 8601 / RFC 3339")
        Divider()
        Picker(selection: $iso8601tz) {
          ForEach(ISO8601Timezone.allCases, id: \.self) { s in
            Text(s.rawValue)
          }
        } label: {
          Text("Timezone")
        }
        Picker(selection: $iso8601format) {
          ForEach(ISO8601Format.allCases, id: \.self) { s in
            Text(s.rawValue)
          }
        } label: {
          Text("Format")
        }
        if iso8601format == .simple {
          // simple formatting
          Picker(selection: $iso8601s) {
            ForEach(ISO8601Seconds.allCases, id: \.self) { s in
              Text(s.rawValue)
            }
          } label: {
            Text("Accuracy")
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
        } else {
          // custom formatting
          TextField("Custom format", text: $iso8601customFormat)
          // BUT: If we are the keyboard, how can a user type a format string here?
          //      For now just prompt the user to paste...
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
