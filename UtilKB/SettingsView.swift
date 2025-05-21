//
//  SettingsView.swift
//  UtilKB
//
//  Created by An So on 2025-05-13.
//

import SwiftUI

struct SettingsView: View {

  let userDefaultsShared: UserDefaults

  @State private var keyboardHeight: Double = 320
  @State private var asciiKeyHeight: Double = 30
  @State private var controlBarKeyHeight: Double = 30

  @State private var reallyReset: Bool = false

  private let appGroupSuiteName: String = "group.com.angdasoft.utilkb"

  public init() {
    self.userDefaultsShared = UserDefaults(suiteName: appGroupSuiteName)!
  }

  var body: some View {
    VStack {
      Text("Preference")
        .font(.headline)
      Text(
        "Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.1") (\(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"))"
      )
        .font(.caption)

      ScrollView {
        GroupBox("General") {
          VStack {
            Text("General Keyboard Height")
            HStack {
              Slider(
                value: $keyboardHeight,
                in: 200...600,
                step: 1,
                label: {}
              )
              .onChange(of: keyboardHeight) { oldValue, newValue in
                userDefaultsShared.set(newValue, forKey: "keyboardHeight")
                userDefaultsShared.synchronize()
              }
              Text("\(Int(keyboardHeight))")
                .frame(width: 50)
            }
            Divider()
            VStack {
              Text("Space Bar Height")
              HStack {
                Slider(
                  value: $controlBarKeyHeight,
                  in: 20...60,
                  step: 1,
                  label: {}
                )
                .onChange(of: controlBarKeyHeight) { oldValue, newValue in
                  userDefaultsShared.set(newValue, forKey: "controlBarKeyHeight")
                  userDefaultsShared.synchronize()
                }
                Text("\(Int(controlBarKeyHeight))")
                  .frame(width: 50)
              }
            }
          }
        }

        GroupBox("ASCII Keyboard") {
          VStack {
            Text("Key Height")
            HStack {
              Slider(
                value: $asciiKeyHeight,
                in: 20...60,
                step: 1,
                label: {}
              )
              .onChange(of: asciiKeyHeight) { oldValue, newValue in
                userDefaultsShared.set(newValue, forKey: "asciiKeyHeight")
                userDefaultsShared.synchronize()
              }
              Text("\(Int(asciiKeyHeight))")
                .frame(width: 50)
            }
          }
        }

        Divider()

        Text("More stuff coming soon...")
          .font(.caption)
          .padding(.vertical, 8)

        Spacer()
        Divider()
        GroupBox("Danger Zone") {
          VStack {
            if reallyReset {
              Text("Are you sure you want to reset everything?")
                .font(.caption)
              Text("This is irreversible.")
                .font(.caption)
              HStack {
                Button(
                  "Reset, really!", role: .destructive
                ) {
                  resetSettings()
                  reallyReset = false
                }.buttonStyle(.borderedProminent)
                Button("No") {
                  reallyReset = false
                }.buttonStyle(.borderedProminent)
              }
            } else {

              Text("This will remove all your customizations.")
                .font(.caption)
              Text("You will need to confirm after tapping the button below.")
                .font(.caption)
              Button("Reset all user settings", role: .destructive) {
                reallyReset = true
              }
              .buttonStyle(.borderedProminent)
            }
          }.padding()
        }
        Spacer()
      }
    }
    .padding()
    .onAppear {
      loadSettings()
    }
  }

  func loadSettings() {
    let savedkeyboardHeight = userDefaultsShared.double(forKey: "keyboardHeight")
    keyboardHeight = savedkeyboardHeight == 0 ? 280 : savedkeyboardHeight

    let savedControlBarKeyHeight = userDefaultsShared.double(forKey: "controlBarKeyHeight")
    controlBarKeyHeight = savedControlBarKeyHeight == 0 ? 30 : savedControlBarKeyHeight

    let savedAsciiKeyHeight = userDefaultsShared.double(forKey: "asciiKeyHeight")
    asciiKeyHeight = savedAsciiKeyHeight == 0 ? 38 : savedAsciiKeyHeight
  }

  func resetSettings() {
    print(userDefaultsShared.dictionaryRepresentation())
    userDefaultsShared.removePersistentDomain(forName: appGroupSuiteName)
    userDefaultsShared.synchronize()
    print(userDefaultsShared.dictionaryRepresentation())
    loadSettings()
  }
}
