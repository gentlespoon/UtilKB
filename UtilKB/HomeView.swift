//
//  HomeView.swift
//  UtilKB
//
//  Created by An So on 2025-05-13.
//

import SwiftUI


struct HomeView: View {
  
  let deviceType = UIDevice.current.userInterfaceIdiom
  
  
  @State private var testText: String = ""
  
  var body: some View {
    VStack(spacing: 0) {
      Text("Utility Keyboard")
        .font(.system(size: 40, weight: .bold))
      ScrollView {
        VStack(alignment: .leading) {
          HStack {
            Text("Made for devlopers and power users")
            if deviceType == .phone {
              Spacer()
              NavigationLink("\(Image(systemName: "gearshape"))") {
                SettingsView()
              }
            }
          }
          Text(
            "Quickly insert timestamp, UUID, hash, dummy name and address, and more with a single tap. Whether you're debugging APIs, filling forms, or testing apps, UtilityBoard saves time and keeps you in flow."
          ).font(.caption)
          Spacer()
          HStack {
            Text("Don't forget to")
            Button("Enable Keyboard \(Image(systemName: "square.and.arrow.up"))") {
              if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl)
              }
            }
            .buttonStyle(.borderless)
          }
          Text(
            "Full access is required if you use any clipboard-related features like base64 or custom string formatting."
          ).font(.caption)
          Divider()
          Text("Keyboard Testing Area").font(.headline)
          TextEditor(text: $testText)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
            )
            .font(.system(size: 12, design: .monospaced))
            .frame(minHeight: 200)
        }
        .padding(20)
      }
    }
  }
  
}
