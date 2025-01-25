# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Categories = %w[トップス ジャケット/アウター パンツ オールインワン・サロペット スカート ワンピース/ドレス フォーマルスーツ/小物 バッグ シューズ アクセサリ その他]
Categories.each do |line|
  Category.create!(name: line)
end

Brands = %w[Uniqlo GU Zara Adidas Nike]
Brands.each do |line|
  Brand.create!(name: line)
end

Colors = %w[赤 青 緑 黒 白]
Colors.each do |line|
  Color.create!(name: line)
end
