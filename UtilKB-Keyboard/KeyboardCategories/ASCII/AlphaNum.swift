//
//  AlphaNum.swift
//  UtilKB
//
//  Created by An So on 2025-05-19.
//

import SwiftUI

struct AsciiButtonStyle: ButtonStyle {
  let buttonWidth: CGFloat
  let buttonHeight: CGFloat
  let background: Color

  public func makeBody(configuration: Self.Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label
        .foregroundStyle(.primary)
        .opacity(configuration.isPressed ? 0.4 : 1.0)
      Spacer()
    }
    .background(background)
    .frame(maxWidth: buttonWidth, idealHeight: buttonHeight)
    .cornerRadius(4)
  }
}

struct FreeWidthButtonStyle: ButtonStyle {
  let buttonHeight: CGFloat
  let background: Color

  public func makeBody(configuration: Self.Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label
        .foregroundStyle(.primary)
        .opacity(configuration.isPressed ? 0.4 : 1.0)
      Spacer()
    }
    .background(background)
    .frame(maxWidth: .infinity, idealHeight: buttonHeight)
    .cornerRadius(4)
  }
}

enum AsciiKeyboardType: String, CaseIterable {
  case simple = "Simple"
  case full = "Full"
}

enum ShiftState {
  case none
  case shift
  case locked
}

struct AlphaNumView: KeyboardCategoryView {
  @StateObject private var settings = KeyboardSettings.shared
  let insertText: (String) -> Void

  private let buttonSpacing: CGFloat = 4
  private let fontSize: CGFloat = 17

  @State var activeLayout: [ShiftState: [[String]]]? = nil
  @State var keyboardType: AsciiKeyboardType = .simple
  @State var shiftState: ShiftState = .none
  @State var lastShiftPressTime: Date?
  @State var screenWidth: CGFloat = 300
  @State var buttonWidth: CGFloat = 16

  var body: some View {
    VStack(spacing: buttonSpacing) {
      if activeLayout != nil {
        layoutView
          .buttonStyle(
            AsciiButtonStyle(
              buttonWidth: buttonWidth,
              buttonHeight: CGFloat(settings.asciiKeyHeight),
              background: shiftState == .locked
                ? .secondary.opacity(0.45)
                : shiftState == .shift ? .secondary.opacity(0.3) : .secondary.opacity(0.15)
            ))
      }
    }
    .frame(maxWidth: .infinity)
    .padding(buttonSpacing)
    .onAppear {
      screenWidth = UIScreen.main.bounds.width
      activeLayout =
        keyboardType == .full ? layout[AsciiKeyboardType.full]! : layout[AsciiKeyboardType.simple]!
      buttonWidth = screenWidth / CGFloat((activeLayout![.none]!.map { $0.count }.max() ?? 1))
    }
  }

  var layoutView: some View {
    VStack {
      auxKeyRow
      ScrollView {
        keyboardView
      }
    }
    .frame(maxWidth: .infinity)
    
  }

  var keyboardView: some View {
    VStack {
      let activeLayoutWithShiftState =
        shiftState == .none ? activeLayout![ShiftState.none] : activeLayout![ShiftState.shift]
      ForEach(activeLayoutWithShiftState!, id: \.self) { row in
        HStack(spacing: buttonSpacing) {
          ForEach(row, id: \.self) { char in
            if char == "" {
              Spacer()
            }
            else {
              Button {
                insertText(char)
                if shiftState != .locked {
                  shiftState = .none
                }
              } label: {
                Text(char)
                  .frame(height: settings.asciiKeyHeight)
                  .font(.system(size: fontSize).monospaced())
              }
            }
          }
        }
      }
    }

  }

  var auxKeyRow: some View {
    HStack {
      ControlGroup {
        Button {
          let now = Date()
          // double tap
          if let lastPress = lastShiftPressTime,
            now.timeIntervalSince(lastPress) < 0.6
          {
            shiftState = .locked
            return
          }
          // single tap
          switch shiftState {
          case .shift:
            shiftState = .none
          case .locked:
            shiftState = .none
          case .none:
            shiftState = .shift
          }
          lastShiftPressTime = now
        } label: {
          let shiftText = shiftState == .locked ? "SHIFT" : shiftState == .shift ? "Shift" : "shift"
          Text(shiftText)
            .foregroundStyle(.primary)
            .frame(height: settings.asciiKeyHeight)
            .font(.system(size: fontSize).monospaced())
        }
        // tab
        Button {
          insertText("\t")
        } label: {
          Text("Tab")
            .labelStyle(.titleOnly)
            .foregroundStyle(.primary)
            .frame(height: settings.asciiKeyHeight)
            .font(.system(size: fontSize).monospaced())
        }
      }
      .controlGroupStyle(.automatic)

      // <- ->
      ControlGroup {
        Button {
          insertText("[left]")
        } label: {
          Label("left", systemImage: "arrow.backward")
            .foregroundStyle(.primary)
            .frame(height: settings.asciiKeyHeight)
        }
        Button {
          insertText("[right]")
        } label: {
          Label("right", systemImage: "arrow.forward")
            .foregroundStyle(.primary)
            .frame(height: settings.asciiKeyHeight)
        }
      }
      .controlGroupStyle(.automatic)

      // simple or full?
      Picker("", selection: $keyboardType) {
        ForEach(AsciiKeyboardType.allCases, id: \.self) { kbType in
          Text(kbType.rawValue)
        }
      }
      .pickerStyle(.segmented)
      .fixedSize()
      .onChange(of: keyboardType) { oldValue, newValue in
        activeLayout =
          newValue == .full ? layout[AsciiKeyboardType.full]! : layout[AsciiKeyboardType.simple]!
        buttonWidth = screenWidth / CGFloat((activeLayout![.none]!.map { $0.count }.max() ?? 1))
      }
    }
    .foregroundStyle(.primary)

  }
}
