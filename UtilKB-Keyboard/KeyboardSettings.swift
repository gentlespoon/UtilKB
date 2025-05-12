import SwiftUI

class KeyboardSettings: ObservableObject {
  static let shared = KeyboardSettings()

  // MARK: - Category Settings
  @Published var activeCategory: KeyboardCategory {
    didSet {
      UserDefaults.standard.set(activeCategory.rawValue, forKey: "lastActiveCategory")
    }
  }

  // MARK: - Dummy Data Settings
  @Published var loremIpsumCount: Int {
    didSet {
      UserDefaults.standard.set(loremIpsumCount, forKey: "loremIpsumCount")
    }
  }

  @Published var dummyIdCountry: DummyIdCountry {
    didSet {
      UserDefaults.standard.set(dummyIdCountry.rawValue, forKey: "dummyIdCountry")
    }
  }

  // MARK: - Datetime Settings
  @Published var epochSeconds: EpochSeconds {
    didSet {
      UserDefaults.standard.set(epochSeconds.rawValue, forKey: "epochSeconds")
    }
  }

  @Published var iso8601tz: ISO8601Timezone {
    didSet {
      UserDefaults.standard.set(iso8601tz.rawValue, forKey: "iso8601tz")
    }
  }

  @Published var iso8601format: ISO8601Format {
    didSet {
      UserDefaults.standard.set(iso8601format.rawValue, forKey: "iso8601format")
    }
  }

  @Published var iso8601s: ISO8601Seconds {
    didSet {
      UserDefaults.standard.set(iso8601s.rawValue, forKey: "iso8601s")
    }
  }

  @Published var iso8601os: ISO8601Offset {
    didSet {
      UserDefaults.standard.set(iso8601os.rawValue, forKey: "iso8601os")
    }
  }

  @Published var iso8601customFormat: String {
    didSet {
      UserDefaults.standard.set(iso8601customFormat, forKey: "iso8601customFormat")
    }
  }

  // MARK: - Random Settings
  @Published var uuidv4Case: UUIDv4Case {
    didSet {
      UserDefaults.standard.set(uuidv4Case.rawValue, forKey: "uuidv4Case")
    }
  }

  private init() {
    // Initialize activeCategory
    if let savedCategory = UserDefaults.standard.string(forKey: "lastActiveCategory"),
      let category = KeyboardCategory(rawValue: savedCategory)
    {
      self.activeCategory = category
    } else {
      self.activeCategory = .none
    }

    // Initialize Dummy Data settings
    let loremIpsumCount = UserDefaults.standard.integer(forKey: "loremIpsumCount")
    self.loremIpsumCount = loremIpsumCount != 0 ? loremIpsumCount : 1

    if let savedCountry = UserDefaults.standard.string(forKey: "dummyIdCountry"),
      let country = DummyIdCountry(rawValue: savedCountry)
    {
      self.dummyIdCountry = country
    } else {
      self.dummyIdCountry = .UK
    }

    // Initialize Datetime settings
    if let savedEpochSeconds = UserDefaults.standard.string(forKey: "epochSeconds"),
      let epochSeconds = EpochSeconds(rawValue: savedEpochSeconds)
    {
      self.epochSeconds = epochSeconds
    } else {
      self.epochSeconds = .s
    }

    if let savedTz = UserDefaults.standard.string(forKey: "iso8601tz"),
      let tz = ISO8601Timezone(rawValue: savedTz)
    {
      self.iso8601tz = tz
    } else {
      self.iso8601tz = .local
    }

    if let savedFormat = UserDefaults.standard.string(forKey: "iso8601format"),
      let format = ISO8601Format(rawValue: savedFormat)
    {
      self.iso8601format = format
    } else {
      self.iso8601format = .simple
    }

    if let savedSeconds = UserDefaults.standard.string(forKey: "iso8601s"),
      let seconds = ISO8601Seconds(rawValue: savedSeconds)
    {
      self.iso8601s = seconds
    } else {
      self.iso8601s = .s
    }

    if let savedOffset = UserDefaults.standard.string(forKey: "iso8601os"),
      let offset = ISO8601Offset(rawValue: savedOffset)
    {
      self.iso8601os = offset
    } else {
      self.iso8601os = .p0000
    }

    self.iso8601customFormat =
      UserDefaults.standard.string(forKey: "iso8601customFormat") ?? "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    // Initialize Random settings
    if let savedCase = UserDefaults.standard.string(forKey: "uuidv4Case"),
      let uuidCase = UUIDv4Case(rawValue: savedCase)
    {
      self.uuidv4Case = uuidCase
    } else {
      self.uuidv4Case = .upper
    }
  }
}
