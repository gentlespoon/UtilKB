//
//  DummyIdentityList.swift
//  UtilKB
//
//  Created by An So on 2025-05-12.
//



enum DummyIdCountry: String, CaseIterable {
  case US = "United States"
  case UK = "United Kingdom"
  case CA = "Canada"
  case CN = "China"
  case RU = "Russia"
  case IN = "India"
  case JP = "Japan"
}

let dummyIdList: [DummyIdCountry: [String: [String]]] = [
  .US: [  // Based on "The Great Gatsby" by F. Scott Fitzgerald
    "firstNames": [
      "Jay", "Nick", "Daisy", "Tom", "Jordan", "Myrtle", "George", "Meyer", "Catherine",
      "Chester", "Henry", "Owl", "Klipspringer", "Michaelis", "Dan", "Bill", "Henry", "Francis",
      "Walter", "Edgar", "Ewing", "Claude", "Rosy", "Gloria", "Lucille", "Ella", "Violet",
      "Beatrice", "Cecilia", "Eleanor",
    ],
    "lastNames": [
      "Gatsby", "Carraway", "Buchanan", "Wilson", "Baker", "Wolfsheim", "McKee", "Cody",
      "Sloane", "Pammy", "Klipspringer", "Michaelis", "Cody", "Dan", "Bill", "Henry", "Francis",
      "Walter", "Edgar", "Ewing", "Claude", "Rosy", "Gloria", "Lucille", "Ella", "Violet",
      "Beatrice", "Cecilia", "Eleanor",
    ],
    "streetAddresses": [
      "120 West Egg", "20 West Egg", "1 East Egg", "158 East Egg", "350 West Egg",
      "158 West Egg", "158 East Egg", "158 Long Island", "158 New York", "158 Manhattan",
      "158 Queens", "158 Brooklyn", "158 Bronx", "158 Staten Island", "158 New Jersey",
      "158 Connecticut", "158 Rhode Island", "158 Massachusetts", "158 Vermont",
      "158 New Hampshire",
    ],
    "cities": [
      "West Egg", "East Egg", "New York City", "Manhattan", "Queens", "Brooklyn", "Bronx",
      "Staten Island", "Long Island", "New Jersey", "Connecticut", "Rhode Island",
      "Massachusetts", "Vermont", "New Hampshire", "Maine", "Delaware", "Maryland",
      "Virginia", "Pennsylvania",
    ],
    "states": [
      "New York", "New Jersey", "Connecticut", "Rhode Island", "Massachusetts", "Vermont",
      "New Hampshire", "Maine", "Delaware", "Maryland", "Virginia", "Pennsylvania",
      "Ohio", "Indiana", "Illinois", "Michigan", "Wisconsin", "Minnesota", "Iowa", "Missouri",
    ],
    "zipCodes": [
      "10001", "10002", "10003", "10004", "10005", "10006", "10007", "10008", "10009",
      "10010", "10011", "10012", "10013", "10014", "10015", "10016", "10017", "10018",
      "10019", "10020",
    ],
    "phoneNumbers": [
      "+1 2125550001", "+1 2125550002", "+1 2125550003", "+1 2125550004", "+1 2125550005",
      "+1 2125550006", "+1 2125550007", "+1 2125550008", "+1 2125550009", "+1 2125550010",
    ],
  ],
  .UK: [  // Based on "Harry Potter" by J.K. Rowling
    "firstNames": [
      "Albus", "Bellatrix", "Cedric", "Draco", "Ernie", "Fleur", "Gellert", "Hermione", "Igor",
      "James", "Kingsley", "Luna", "Minerva", "Neville", "Olympe", "Peter", "Quirinus", "Ron",
      "Severus", "Tom", "Umbridge", "Vernon", "Wilhelmina", "Xenophilius", "Yvonne", "Zacharias",
    ],
    "lastNames": [
      "Abbott", "Black", "Crouch", "Dumbledore", "Evans", "Filch", "Gaunt", "Granger", "Imago",
      "Jugson", "Krum", "Lovegood", "Macmillan", "Nott", "Ollivander", "Potter", "Quirrell",
      "Riddle", "Shacklebolt", "Tonks", "Urquhart", "Vane", "Weasley", "Xavier", "Yaxley",
      "Zabini",
    ],
    "streetAddresses": [
      "4 Privet Drive", "7 Magnolia Crescent", "12 Grimmauld Place", "1 Spinner's End",
      "1 The Riddle House", "1 Railview Hotel, Room 17", "1 Little Whinging Street",
      "1 Station Road", "1 Wisteria Walk", "1 Magnolia Road",
    ],
    "cities": [
      "Little Whinging", "London", "Cokeworth", "Little Hangleton", "Edinburgh", "Manchester",
      "Birmingham", "Liverpool", "Leeds", "Glasgow", "Bristol", "Cardiff", "Belfast",
      "Newcastle", "Sheffield", "Leicester", "Coventry", "Hull", "Plymouth", "Stoke-on-Trent",
    ],
    "states": [
      "England", "Scotland", "Wales", "Northern Ireland", "Greater London", "West Midlands",
      "North West", "Yorkshire and the Humber", "South East", "East of England", "South West",
      "East Midlands", "North East",
    ],
    "zipCodes": [
      "NG31 6QT", "M1A 1B2", "E1W 1UH", "W1A 1AA", "EC1A 1BB", "SW1A 1AA", "NW1A 1AA",
      "EC1A 1BB", "B1 1BB", "L1 1AA", "LS1 1AA", "G1 1AA", "BS1 1AA", "CF10 1AA", "BT1 1AA",
      "NE1 1AA", "S1 1AA", "LE1 1AA", "CV1 1AA", "HU1 1AA",
    ],
    "phoneNumbers": [
      "+44 1234567890", "+44 2345678901", "+44 3456789012", "+44 4567890123", "+44 5678901234",
      "+44 6789012345", "+44 7890123456", "+44 8901234567", "+44 9012345678", "+44 0123456789",
    ],
  ],
  .CA: [  // Based on "Anne of Green Gables" by L.M. Montgomery
    "firstNames": [
      "Anne", "Matthew", "Marilla", "Diana", "Gilbert", "Rachel", "Thomas", "Josephine",
      "Jane", "Ruby", "Josie", "Charlie", "Moody", "Jerry", "Minnie", "Prissy", "Tillie",
      "Carrie", "Gertie", "Julia",
    ],
    "lastNames": [
      "Shirley", "Cuthbert", "Barry", "Blythe", "Lynde", "Andrews", "Sloane", "Pye",
      "Gillis", "Spurgeon", "MacPherson", "Sloane", "Buote", "Bell", "Wright", "Sloane",
      "Gillis", "Pye", "MacPherson", "Sloane",
    ],
    "streetAddresses": [
      "Green Gables", "Orchard Slope", "Ingleside", "Windy Poplars", "Avonlea Road",
      "White Way of Delight", "Lover's Lane", "Birch Path", "Dryad's Bubble", "Haunted Wood",
      "Violet Vale", "Idlewild", "Balsam Hollow", "Spook's Lane", "Sunset Valley",
      "Willowmere", "Newbridge", "Carmody", "Bright River", "White Sands",
    ],
    "cities": [
      "Avonlea", "Charlottetown", "Bright River", "Carmody", "Newbridge", "White Sands",
      "Bolingbroke", "Spencervale", "Grafton", "Summerside", "Lowbridge", "Harbor Head",
      "Glen St. Mary", "Four Winds", "Lover's Lane", "Violet Vale", "Idlewild", "Balsam Hollow",
      "Spook's Lane", "Sunset Valley",
    ],
    "states": [
      "Prince Edward Island", "Nova Scotia", "New Brunswick", "Newfoundland", "Quebec",
      "Ontario", "Manitoba", "Saskatchewan", "Alberta", "British Columbia", "Yukon",
      "Northwest Territories", "Nunavut",
    ],
    "zipCodes": [
      "C0A 1A0", "C0A 1B0", "C0A 1C0", "C0A 1D0", "C0A 1E0", "C0A 1F0", "C0A 1G0",
      "C0A 1H0", "C0A 1I0", "C0A 1J0", "C0A 1K0", "C0A 1L0", "C0A 1M0", "C0A 1N0",
      "C0A 1O0", "C0A 1P0", "C0A 1Q0", "C0A 1R0", "C0A 1S0", "C0A 1T0",
    ],
    "phoneNumbers": [
      "+1 9025550001", "+1 9025550002", "+1 9025550003", "+1 9025550004", "+1 9025550005",
      "+1 9025550006", "+1 9025550007", "+1 9025550008", "+1 9025550009", "+1 9025550010",
    ],
  ],
  .CN: [  // Based on "Dream of the Red Chamber" (红楼梦)
    "firstNames": [
      "宝玉", "黛玉", "宝钗", "熙凤", "元春", "探春", "惜春", "李纨", "晴雯", "袭人",
      "明烟", "麝月", "贾", "林", "薛", "王", "史", "湘", "迎", "春",
    ],
    "lastNames": [
      "贾", "林", "薛", "王", "史", "湘", "迎", "春", "探", "惜",
      "李", "晴", "袭", "明", "麝", "贾", "林", "薛", "王", "史",
    ],
    "streetAddresses": [
      "大观园", "怡红院", "潇湘馆", "蘅芜苑", "紫菱洲", "稻香村", "藕香榭", "蘅芜苑",
      "紫菱洲", "稻香村", "藕香榭", "蘅芜苑", "紫菱洲", "稻香村", "藕香榭", "蘅芜苑",
      "紫菱洲", "稻香村", "藕香榭", "蘅芜苑",
    ],
    "cities": [
      "北京", "南京", "苏州", "杭州", "扬州", "金陵", "长安", "洛阳", "开封", "杭州",
      "苏州", "扬州", "金陵", "长安", "洛阳", "开封", "杭州", "苏州", "扬州", "金陵",
    ],
    "states": [
      "北京", "上海", "广东", "江苏", "浙江", "四川", "湖北", "河南", "山东", "福建",
      "湖南", "安徽", "江西", "广西", "云南", "贵州", "陕西", "山西", "甘肃", "青海",
    ],
    "zipCodes": [
      "100000", "200000", "300000", "400000", "500000", "600000", "700000", "800000",
      "900000", "100001", "200001", "300001", "400001", "500001", "600001", "700001",
      "800001", "900001", "100002", "200002",
    ],
    "phoneNumbers": [
      "+86 13812345678", "+86 13912345678", "+86 13712345678", "+86 13612345678",
      "+86 13512345678",
      "+86 13412345678", "+86 13312345678", "+86 13212345678", "+86 13112345678",
      "+86 13012345678",
    ],
  ],
  .RU: [  // Based on "War and Peace" (Война и мир)
    "firstNames": [
      "Пьер", "Наташа", "Андрей", "Мария", "Николай", "Соня", "Анатоль", "Элен",
      "Долохов", "Денисов", "Василий", "Анна", "Борис", "Вера", "Лиза", "Илья", "Василий",
      "Анна", "Борис", "Вера",
    ],
    "lastNames": [
      "Безухов", "Ростова", "Болконский", "Курагин", "Друбецкой", "Карагин", "Долохов",
      "Денисов", "Василий", "Анна", "Борис", "Вера", "Лиза", "Илья", "Василий", "Анна",
      "Борис", "Вера", "Лиза", "Илья",
    ],
    "streetAddresses": [
      "Лысые Горы", "Отрадное", "Богучарово", "Московский дом", "Петербургский дом",
      "Лысые Горы", "Отрадное", "Богучарово", "Московский дом", "Петербургский дом",
      "Лысые Горы", "Отрадное", "Богучарово", "Московский дом", "Петербургский дом",
      "Лысые Горы", "Отрадное", "Богучарово", "Московский дом", "Петербургский дом",
    ],
    "cities": [
      "Москва", "Санкт-Петербург", "Смоленск", "Бородино", "Аустерлиц", "Тильзит",
      "Вязьма", "Калуга", "Тула", "Рязань", "Владимир", "Ярославль", "Кострома",
      "Нижний Новгород", "Казань", "Самара", "Саратов", "Волгоград", "Ростов", "Краснодар",
    ],
    "states": [
      "Москва", "Санкт-Петербург", "Новосибирск", "Екатеринбург", "Нижний Новгород",
      "Казань", "Челябинск", "Омск", "Самара", "Ростов", "Уфа", "Красноярск", "Воронеж",
      "Пермь", "Волгоград", "Краснодар", "Саратов", "Тюмень", "Тольятти", "Ижевск",
    ],
    "zipCodes": [
      "101000", "102000", "103000", "104000", "105000", "106000", "107000", "108000",
      "109000", "110000", "111000", "112000", "113000", "114000", "115000", "116000",
      "117000", "118000", "119000", "120000",
    ],
    "phoneNumbers": [
      "+7 4951234567", "+7 8121234567", "+7 3831234567", "+7 3431234567", "+7 8311234567",
      "+7 8431234567", "+7 3511234567", "+7 3811234567", "+7 8461234567", "+7 8631234567",
    ],
  ],
  .IN: [  // Based on "The God of Small Things" (छोटी-छोटी बातें)
    "firstNames": [
      "राहेल", "एस्था", "अम्मू", "चाको", "बेबी", "मम्माची", "पप्पाची", "कोचू",
      "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू",
      "कोचू", "कोचू", "कोचू",
    ],
    "lastNames": [
      "इप्पे", "पिल्लई", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू",
      "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू", "कोचू",
      "कोचू", "कोचू", "कोचू",
    ],
    "streetAddresses": [
      "अयमनम हाउस", "पैराडाइस पिकल्स", "हिस्ट्री हाउस", "कोट्टयम", "कोच्चि",
      "अयमनम", "कोट्टयम", "कोच्चि", "अयमनम", "कोट्टयम", "कोच्चि", "अयमनम",
      "कोट्टयम", "कोचू", "अयमनम", "कोट्टयम", "कोच्चि", "अयमनम", "कोट्टयम", "कोच्चि",
    ],
    "cities": [
      "अयमनम", "कोट्टयम", "कोच्चि", "तिरुवनंतपुरम", "कोझिकोड", "अलप्पुळ",
      "कोल्लम", "त्रिशूर", "पालक्काड", "थलस्सेरी", "कण्णूर", "कोल्लम", "त्रिशूर",
      "पालक्काड", "थलस्सेरी", "कण्णूर", "कोल्लम", "त्रिशूर", "पालक्काड", "थलस्सेरी",
    ],
    "states": [
      "केरल", "तमिलनाडु", "कर्नाटक", "आंध्र प्रदेश", "तेलंगाना", "महाराष्ट्र",
      "गुजरात", "राजस्थान", "मध्य प्रदेश", "उत्तर प्रदेश", "बिहार", "पश्चिम बंगाल",
      "ओडिशा", "झारखंड", "छत्तीसगढ़", "उत्तराखंड", "हिमाचल प्रदेश", "पंजाब",
      "हरियाणा", "दिल्ली",
    ],
    "zipCodes": [
      "682001", "682002", "682003", "682004", "682005", "682006", "682007", "682008",
      "682009", "682010", "682011", "682012", "682013", "682014", "682015", "682016",
      "682017", "682018", "682019", "682020",
    ],
    "phoneNumbers": [
      "+91 4712345678", "+91 4812345678", "+91 4912345678", "+91 5012345678", "+91 5112345678",
      "+91 5212345678", "+91 5312345678", "+91 5412345678", "+91 5512345678", "+91 5612345678",
    ],
  ],
  .JP: [  // Based on Japanese classics: Genji Monogatari, Kokoro, Botchan, etc.
    "firstNames": [
      "源氏", "紫", "葵", "六条", "夕顔", "末摘花", "空蝉", "朧月夜", "明石", "玉鬘",
      "夏目", "漱石", "正岡", "子規", "森", "鷗外", "与謝野", "晶子", "谷崎", "潤一郎",
    ],
    "lastNames": [
      "光", "式部", "夏目", "漱石", "正岡", "子規", "森", "鷗外", "与謝野", "晶子",
      "谷崎", "潤一郎", "川端", "康成", "三島", "由紀夫", "太宰", "治", "芥川", "龍之介",
    ],
    "streetAddresses": [
      "六条院", "二条院", "三条院", "一条院", "東京都千代田区", "東京都新宿区", "東京都渋谷区",
      "東京都港区", "東京都中央区", "東京都文京区", "東京都台東区", "東京都墨田区", "東京都江東区",
      "東京都品川区", "東京都目黒区", "東京都世田谷区", "東京都中野区", "東京都杉並区", "東京都豊島区",
      "東京都北区", "東京都荒川区",
    ],
    "cities": [
      "京都", "東京", "大阪", "横浜", "名古屋", "札幌", "神戸", "福岡", "仙台", "広島",
      "北九州", "千葉", "川崎", "さいたま", "新潟", "静岡", "浜松", "岡山", "熊本", "鹿児島",
    ],
    "states": [
      "東京都", "大阪府", "京都府", "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
      "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "神奈川県", "新潟県", "富山県", "石川県", "福井県",
    ],
    "zipCodes": [
      "100-0001", "100-0002", "100-0003", "100-0004", "100-0005", "100-0006", "100-0007",
      "100-0008", "100-0009", "100-0010", "100-0011", "100-0012", "100-0013", "100-0014",
      "100-0015", "100-0016", "100-0017", "100-0018", "100-0019", "100-0020",
    ],
    "phoneNumbers": [
      "+81 3123456789", "+81 6123456789", "+81 7523456789", "+81 1123456789", "+81 2223456789",
      "+81 3323456789", "+81 4423456789", "+81 5523456789", "+81 6623456789", "+81 7723456789",
    ],
  ],
]
