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
  case .CN:
    return [
      ("surname", "Surname"),
      ("givenname", "Given name"),
      ("phone", "Phone"),
      ("email", "Email"),
    ]
  case .JP:
    return [
      ("surname", "Surname"),
      ("givenname", "Given name"),
      ("phone", "Phone"),
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
  case .CA:
    return [
      ("street", "Street"),
      ("city", "City"),
      ("province", "Province"),
      ("postalCode", "Postal code"),
    ]
  case .CN:
    return [
      ("postalCode", "Postal code"),
      ("province", "Province"),
      ("city", "City"),
      ("street", "Street"),
    ]
  case .JP:
    return [
      ("postalCode", "Postal code"),
      ("prefecture", "Prefecture"),
      ("city", "City"),
      ("street", "Street"),
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
      "New York", "Manhattan", "Queens", "Brooklyn", "Long Island", "Bronx", "Staten Island",
      "Buffalo", "Albany", "Syracuse",
    ],
    "state": [
      "New York", "New York", "New York", "New York", "New York", "New York", "New York",
      "New York", "New York", "New York",
    ],
    "zipCode": [
      "10001", "10002", "10003", "10004", "10005", "10006", "10007", "10008", "10009", "10010",
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
      "London", "Hogsmeade", "Godric's Hollow", "Little Whinging", "Diagon Alley",
    ],
    "country": [
      "England", "Scotland", "England", "England", "England",
    ],
    "postcode": [
      "W1A 1AA", "EC1A 1BB", "SW1A 1AA", "NW1 1AA", "SE1 1AA",
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
      "Charlottetown", "Avonlea", "Bright River", "Carmody", "Newbridge",
    ],
    "province": [
      "Prince Edward Island", "Prince Edward Island", "Prince Edward Island",
      "Prince Edward Island", "Prince Edward Island",
    ],
    "postalCode": [
      "C0A 1A0", "C0A 1B0", "C0A 1C0", "C0A 1D0", "C0A 1E0",
    ],
    "phone": [
      "+1 9025550001", "+1 9025550002",
    ],
  ],

  .CN: [  // 现代中国题材人物与地址
    "givenname": [
      "胜美", "筱绡", "莹莹", "雎尔", "明玉", "明成", "晓玲", "焕英", "光林",
      "睿", "雪", "楠", "欣", "倩", "宁", "天乐", "子瑜", "雨桐", "子涵", "思远",
      "晨曦", "嘉怡", "宇轩", "思彤", "梓萱", "梓轩", "子墨", "若彤", "梓萌", "子睿",
    ],
    "surname": [
      "安", "樊", "曲", "邱", "关", "苏", "贾", "李", "沈", "陈", "张", "刘", "赵", "孙",
      "周", "徐", "黄", "何", "高", "林", "郭", "马", "罗", "梁", "宋", "郑", "谢",
    ],
    "street": [
      "人民路 {number} 号", "解放大道 {number} 号", "建设路 {number} 号",
      "光谷大道 {number} 号", "长安街 {number} 号", "天府大道 {number} 号",
      "虹桥路 {number} 号", "南山大道 {number} 号", "中关村东路 {number} 号",
      "南京东路 {number} 号", "望京街 {number} 号", "金融街 {number} 号",
      "珠江新城路 {number} 号", "西湖路 {number} 号", "天河路 {number} 号",
      "国贸大道 {number} 号", "五道口街 {number} 号", "新街口大街 {number} 号",
    ],
    "city": [
      "北京", "上海", "广州", "深圳", "南京", "杭州", "成都", "重庆", "武汉", "西安",
      "天津", "苏州", "青岛", "厦门", "宁波",
    ],
    "province": [
      "北京", "上海", "广东", "广东", "江苏", "浙江", "四川", "重庆", "湖北", "陕西",
      "天津", "江苏", "山东", "福建", "浙江",
    ],
    "postalCode": [
      "100000", "200000", "510000", "518000", "210000", "310000", "610000",
      "400000", "430000", "710000", "300000", "215000", "266000", "361000", "315000",
    ],
    "phone": [
      "+86 13812345678", "+86 13998765432", "+86 13711223344", "+86 13666554433",
      "+86 13599887766", "+86 13455667788", "+86 13123456789", "+86 15012345678",
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
      "Москва", "Санкт-Петербург", "Смоленск", "Тверь", "Калуга", "Ярославль",
    ],
    "province": [
      "Московская область", "Санкт-Петербург", "Смоленская область", "Тверская область",
      "Калужская область", "Ярославская область",
    ],
    "postalCode": [
      "101000", "190000", "214000", "101001", "190001", "214001",
    ],
    "phone": [
      "+7 4951234567", "+7 8121234567",
    ],
  ],

  .JP: [  // 君の名は (Your Name)
    "givenname": [
      "瀧", "三葉", "四葉", "勅使河原", "名取", "早耶香", "司", "高木", "宮水", "俊樹",
    ],
    "surname": [
      "立花", "宮水", "勅使河原", "名取", "高木", "藤井", "大垣", "奥寺", "小野寺", "神木",
    ],
    "street": [
      "新宿通り {number}-{number}-{number}", "千駄ヶ谷 {number}-{number}-{number}",
      "四ツ谷 {number}-{number}-{number}", "飯田橋 {number}-{number}-{number}",
      "代々木 {number}-{number}-{number}", "糸守町中央通り {number}-{number}",
      "御神体参道 {number}-{number}",
    ],
    "city": [
      "新宿区", "千代田区", "中野区", "渋谷区", "糸守町",
    ],
    "prefecture": [
      "東京都", "東京都", "東京都", "東京都", "岐阜県",
    ],
    "postalCode": [
      "160-0022", "102-0072", "164-0001", "151-0053", "509-6123",
    ],
    "phone": [
      "+81 3 1234 5678", "+81 3 2345 6789", "+81 3 3456 7890",
    ],
  ],
]
