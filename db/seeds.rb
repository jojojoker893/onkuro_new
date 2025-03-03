# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Categories = %w[トップス ジャケット/アウター パンツ オールインワン・サロペット スカート ワンピース/ドレス フォーマルスーツ/小物 バッグ シューズ アクセサリ その他]
Categories.each do |line|
  Category.create!(name: line)
end

Brands = %w[LouisVuitton CHANEL Hermès Gucci Prada Dior Balenciaga SaintLaurent Fendi BottegaVeneta CommedesGarçons UNIQLO Nike Adidas ZARA H&M BEAMS URBANRESEARCH nano・universe AcneStudios]
Brands.each do |line|
  Brand.create!(name: line)
end

Colors = %w[赤 青 緑 黄 オレンジ 紫 ピンク 茶 白 黒 灰 ベージュ]
Colors.each do |line|
  Color.create!(name: line)
end
