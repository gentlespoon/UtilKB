//
//  KeyboardViewController.swift
//  UtilityBoard
//
//  Created by An So on 2025-05-11.
//

import SwiftUI
import UIKit

class KeyboardViewController: UIInputViewController {
  var undoStack: [String] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    let keyboard = KeyboardView(
      viewController: self,
      insertText: { [weak self] text in
        let previousContent = self?.textDocumentProxy.documentContextBeforeInput ?? ""
        switch text {
        case "[clear]":
          while self?.textDocumentProxy.hasText ?? false {
            self?.textDocumentProxy.deleteBackward()
          }
        case "[delete]":
          if !previousContent.isEmpty {
            self?.undoStack.append(previousContent)
          }
          self?.textDocumentProxy.deleteBackward()
        case "[undo]":
          while self?.textDocumentProxy.hasText ?? false {
            self?.textDocumentProxy.deleteBackward()
          }
          if let previousText = self?.undoStack.popLast() {
            self?.textDocumentProxy.insertText(previousText)
          }
        case "[left]":
          self?.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
        case "[right]":
          self?.textDocumentProxy.adjustTextPosition(byCharacterOffset: 1)
        case "[nextKeyboard]":
          self?.advanceToNextInputMode()
        default:
          if !previousContent.isEmpty {
            self?.undoStack.append(previousContent)
          }
          self?.textDocumentProxy.insertText(text)
        }
      },
      deviceType: UIDevice.current.userInterfaceIdiom
    )

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
