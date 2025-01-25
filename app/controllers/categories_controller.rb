class CategoriesController < ApplicationController
  def index
    @categories = current_user.clothes
    .includes(:category)
    .group
  end
end

# 各カテゴリごとの服を表示したい
