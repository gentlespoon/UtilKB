//
//  ContentView.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

struct ContentView: View {
  
  let deviceType = UIDevice.current.userInterfaceIdiom

  var body: some View {
    VStack {
      if deviceType == .pad {
        HStack {
          HomeView()
            .frame(width: 360)
          Divider()
          SettingsView()
        }
      } else {
        NavigationView {
          HomeView()
        }
      }
    }
    .background(.background)
  }
    
  
  
}

#Preview {
  ContentView()
}
