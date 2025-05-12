//
//  KeyboardViewController.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI
import UIKit

class KeyboardViewController: UIInputViewController {
  var undoStack: [Int] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    let keyboard = KeyboardView { [weak self] text in
      switch text {
      case "[delete]":
        self?.textDocumentProxy.deleteBackward()
      case "[undo]":
        if self?.undoStack.count ?? 0 > 0 {
          for _ in 0..<self!.undoStack.popLast()! {
            self?.textDocumentProxy.deleteBackward()
          }
        }
      default:
        self?.undoStack.append(text.count)
        self?.textDocumentProxy.insertText(text)
      }
    }

    let hosting = UIHostingController(rootView: keyboard)
    addChild(hosting)
    view.addSubview(hosting.view)

    hosting.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
      hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])

    hosting.didMove(toParent: self)
  }
}
