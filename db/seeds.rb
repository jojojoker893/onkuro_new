# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Categories = %w[トップス ボトムス アウター アクセサリー]
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
