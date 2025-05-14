//
//  SettingsView.swift
//  UtilKB
//
//  Created by An So on 2025-05-13.
//

import SwiftUI

struct SettingsView: View {
  let userDefaultsShared: UserDefaults

  @State private var keyboardHeight: Double = 280

  public init() {
    self.userDefaultsShared = UserDefaults(suiteName: "group.com.angdasoft.utilkb")!
  }

  var body: some View {
    VStack {
      Text("Preference")
        .font(.headline)
      HStack {
        Text("Height")
        Slider(
          value: $keyboardHeight,
          in: 200...500,
          step: 10,
          label: {}
        )
        .onChange(of: keyboardHeight) { oldValue, newValue in
          userDefaultsShared.set(newValue, forKey: "keyboardHeight")
        }
        Text("\(Int(keyboardHeight))")
          .frame(width: 50)
      }
      Spacer()
    }
    .padding()
    .onAppear {
      let savedkeyboardHeight = userDefaultsShared.double(forKey: "keyboardHeight")
      keyboardHeight = savedkeyboardHeight == 0 ? 280 : savedkeyboardHeight
    }
  }
}
