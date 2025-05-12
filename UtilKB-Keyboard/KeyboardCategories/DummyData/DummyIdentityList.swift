//
//  DummyIdentityList.swift
//  UtilKB
//
//  Created by An So on 2025-05-12.
//

import Foundation

enum DummyIdCountry: String, CaseIterable {
  case US = "United States"
  case UK = "United Kingdom"
  case CA = "Canada"
  case CN = "China"
  case RU = "Russia"
  case JP = "Japan"
}

func piiFormats(_ country: DummyIdCountry) -> [(String, String)] {
  switch country {
  case .US, .UK, .CA, .RU:
    return [
      ("givenname", "Given name"),
      ("surname", "Surname"),
      ("phone", "Phone"),
      ("email", "Email"),
    ]

  case .CN, .JP:
    return [
      ("surname", "Surname"),
      ("givenname", "Given name"),
      ("phone", "Phone"),
      ("email", "Email"),
    ]
  }
}

func countryAddressFormats(_ country: DummyIdCountry) -> [(String, String)] {
  switch country {
  case .US:
    return [
      ("street", "Street"),
      ("city", "City"),
      ("state", "State"),
      ("zipCode", "ZIP code"),
    ]
  case .UK:
    return [
      ("street", "Street"),
      ("city", "City"),
      ("country", "Country"),
      ("postcode", "Postcode"),
    ]
  case .CA, .CN:
    return [
      ("street", "Street"),
      ("city", "City"),
      ("province", "Province"),
      ("postalCode", "Postal code"),
    ]
  case .JP:
    return [
      ("street", "Street"),
      ("city", "City"),
      ("prefecture", "Prefecture"),
      ("postalCode", "Postal code"),
    ]
  case .RU:
    return [
      ("street", "Street"),
      ("city", "City"),
      ("region", "Region"),
      ("postalCode", "Postal code"),
    ]
  }
}

let dummyIdList: [DummyIdCountry: [String: [String]]] = [
  .US: [  // The Great Gatsby
    "givenname": [
      "Jay", "Nick", "Daisy", "Tom", "Jordan", "Myrtle", "George", "Meyer", "Catherine",
      "Chester", "Henry", "Michaelis", "Dan", "Bill", "Francis", "Walter", "Edgar", "Ewing",
      "Claude",
    ],
    "surname": [
      "Gatsby", "Carraway", "Buchanan", "Wilson", "Baker", "Wolfsheim", "McKee", "Cody",
      "Sloane", "Klipspringer", "Michaelis", "Gatz",
    ],
    "street": [
      "West Egg Road", "East Egg Street", "Long Island Blvd", "Queensboro Bridge",
      "Manhattan Avenue", "Fifth Avenue", "Park Lane", "East 61st Street", "Times Square",
      "Riverside Drive",
    ],
    "city": [
      "West Egg", "East Egg", "New York", "Manhattan", "Queens", "Brooklyn", "Long Island",
    ],
    "state": [
      "New York", "New Jersey", "Connecticut",
    ],
    "zipCode": [
      "10001", "10002", "10003", "10004", "10005",
    ],
    "phone": [
      "+1 2125550001", "+1 2125550002", "+1 2125550003",
    ],
  ],

  .UK: [  // Harry Potter
    "givenname": [
      "Albus", "Bellatrix", "Cedric", "Draco", "Fleur", "Hermione", "James", "Luna", "Minerva",
      "Neville", "Peter", "Ron", "Severus", "Tom",
    ],
    "surname": [
      "Dumbledore", "Black", "Diggory", "Malfoy", "Delacour", "Granger", "Potter",
      "Lovegood", "McGonagall", "Longbottom", "Pettigrew", "Weasley", "Snape", "Riddle",
    ],
    "street": [
      "4 Privet Drive", "12 Grimmauld Place", "{number} Spinner's End", "{number} Diagon Alley",
      "{number} Knockturn Alley",
    ],
    "city": [
      "Little Whinging", "London", "Hogsmeade", "Godric's Hollow",
    ],
    "country": [
      "England", "Scotland",
    ],
    "postcode": [
      "W1A 1AA", "EC1A 1BB", "SW1A 1AA",
    ],
    "phone": [
      "+44 1234567890", "+44 2345678901",
    ],
  ],

  .CA: [  // Anne of Green Gables
    "givenname": [
      "Anne", "Matthew", "Marilla", "Diana", "Gilbert", "Rachel", "Ruby", "Josie",
    ],
    "surname": [
      "Shirley", "Cuthbert", "Barry", "Blythe", "Lynde", "Pye", "Gillis", "Wright",
    ],
    "street": [
      "{number} Green Gables", "{number} Lover's Lane", "{number} White Sands Road",
      "{number} Avonlea Road", "{number} Orchard Slope",
    ],
    "city": [
      "Avonlea", "Charlottetown", "Bright River", "Carmody", "Newbridge", "White Sands",
    ],
    "province": [
      "Prince Edward Island", "Nova Scotia",
    ],
    "postalCode": [
      "C0A 1A0", "C0A 1B0", "C0A 1C0",
    ],
    "phone": [
      "+1 9025550001", "+1 9025550002",
    ],
  ],

  .CN: [  // 红楼梦
    "givenname": [
      "宝玉", "黛玉", "宝钗", "熙凤", "元春", "探春", "惜春", "纨", "晴雯", "袭人",
    ],
    "surname": [
      "贾", "林", "薛", "王", "史", "李",
    ],
    "street": [
      "大观园 {number} 号", "怡红院 {number} 号", "潇湘馆 {number} 号", "蘅芜苑 {number} 号", "稻香村 {number} 号",
    ],
    "city": [
      "金陵", "苏州", "杭州", "扬州",
    ],
    "province": [
      "江苏", "浙江", "安徽", "山东",
    ],
    "postalCode": [
      "210000", "310000", "400000", "500000",
    ],
    "phone": [
      "+86 13812345678", "+86 13912345678",
    ],
  ],

  .RU: [  // Война и миръ
    "givenname": [
      "Пьер", "Наташа", "Андрей", "Мария", "Николай", "Соня", "Анатоль", "Элен", "Борис", "Анна",
    ],
    "surname": [
      "Безухов", "Ростова", "Болконский", "Курагин", "Друбецкой", "Долохов", "Денисов",
    ],
    "street": [
      "Лысые Горы {number}", "Отрадное {number}", "Богучарово {number}", "Московский дом {number}",
      "Петербургский дом {number}",
    ],
    "city": [
      "Москва", "Санкт-Петербург", "Смоленск",
    ],
    "province": [
      "Московская область", "Санкт-Петербург", "Смоленская область",
    ],
    "postalCode": [
      "101000", "190000", "214000",
    ],
    "phone": [
      "+7 4951234567", "+7 8121234567",
    ],
  ],

  .JP: [  // 金閣寺
    "givenname": [
      "溝口", "鶴川", "柏木", "清子", "南", "高橋", "中村", "三島",
    ],
    "surname": [
      "溝口", "鶴川", "柏木", "南", "高橋", "中村", "野田", "佐々木",
    ],
    "street": [
      "銀閣寺道 {number}-{number}-{number}", "哲学の道 {number}-{number}-{number}",
      "北白川通 {number}-{number}-{number}",
      "五条通 {number}-{number}-{number}",
      "四条大宮 {number}-{number}-{number}", "堀川通 {number}-{number}-{number}",
      "西大路通 {number}-{number}-{number}",
    ],
    "city": [
      "京都市", "奈良市", "金沢市", "神戸市", "広島市",
    ],
    "prefecture": [
      "京都府", "奈良県", "石川県", "兵庫県", "広島県",
    ],
    "postalCode": [
      "606-8402", "630-8215", "920-0853", "650-0011", "730-0031",
    ],
    "phone": [
      "+81 75 123 4567", "+81 78 987 6543",
    ],
  ],
]
