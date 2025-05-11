
Categories = %w[トップス ジャケット/アウター パンツ オールインワン・サロペット スカート ワンピース/ドレス フォーマルスーツ/小物 バッグ シューズ アクセサリ その他]
Categories.each do |line|
  Category.create!(name: line)
end

Brands = %w[
  LouisVuitton CHANEL Hermès Gucci Prada Dior Balenciaga SaintLaurent Fendi
  BottegaVeneta Loewe CELINE Burberry Valentino AlexanderMcQueen Givenchy MiuMiu
  UNIQLO GU ZARA H&M GAP Bershka Forever21 SHEIN WEGO GLOBAL_WORK niko_and...
  Nike Adidas Puma Reebok NewBalance ASICS Champion FILA Converse VANS
  THE_NORTH_FACE Patagonia Columbia UnderArmour DESCENTE Arc'teryx
  Supreme STÜSSY X-LARGE BAPE KITH OffWhite AderError PALACE CarharttWIP
  WTAPS Neighborhood HUMANMADE FearOfGod Essentials
  UNITED_ARROWS BEAUTY&YOUTH JOURNAL_STANDARD SHIPS BEAMS URBANRESEARCH
  nano・universe EDIFICE STUDIOUS PublicTokyo nonnative COMOLI YAECA AURALEE kolor sacai
  Stylenanda CHUU Mixxmix IMVELY GentleMonster LIPHOP Dunst
  MIKIHOUSE BABYDOLL BREEZE MARKEY’S petitbateau その他
]
Brands.each do |line|
  Brand.create!(name: line)
end

Colors = %w[赤 青 緑 黄 オレンジ 紫 ピンク 茶 白 黒 灰 ベージュ]
Colors.each do |line|
  Color.create!(name: line)
end
