//
//  KeyboardViewController.swift
//  Engineer Keyboard
//
//  Created by An So on 2025-05-11.
//
import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let keyboard = KeyboardView { [weak self] text in
      if text == "" {
        self?.textDocumentProxy.deleteBackward()
      } else {
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
