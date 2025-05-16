//
//  DummyData.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-12.
//

import SwiftUI
import UIKit

struct DummyDataCategoryView: KeyboardCategoryView {
  @StateObject private var settings = KeyboardSettings.shared
  let insertText: (String) -> Void

  var body: some View {
    List {
      LoremIpsumView(insertText: insertText)
      DummyIdentityView(insertText: insertText)
    }
    .buttonStyle(.bordered)
    .listStyle(.plain)
  }

  

 

  
}
