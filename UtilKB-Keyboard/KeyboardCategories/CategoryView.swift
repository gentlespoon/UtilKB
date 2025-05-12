//
//  CategoryView.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI

protocol KeyboardCategoryView: View {
  var insertText: (String) -> Void { get }
}
