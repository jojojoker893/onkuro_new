class Clothing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to :color

  has_one_attached :image
  has_many :clothing_usage_logs, dependent: :destroy
  has_many :usage_log_clearing, dependent: :destroy

  # @@登録順
  scope :order_created_at, -> { order(created_at: :desc) }

  # @@使用回数の降順、昇順で並び替え
  scope :order_usage, ->(sort_order = "DESC") { order(Arel.sql("usage_count #{sort_order}")) }

  # @@絞り機能 カテゴリ、ブランド、カラー
  scope :filter_category, ->(category_id) { where(category_id: category_id)  if category_id.present? }
  scope :filter_brand, ->(brand_id) { where(brand_id: brand_id)  if brand_id.present? }
  scope :filter_color, ->(color_id) { where(color_id: color_id)  if color_id.present? }

  # @@検索機能
  scope :search_keyword, ->(keyword) { where("name LIKE ?", "%" + keyword + "%") }

  def usage_total_count
    [ clothing_usage_logs.count - usage_log_clearing.count, 0 ].max
  end
end
