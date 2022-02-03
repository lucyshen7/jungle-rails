class Admin::DashboardController < ApplicationController
  def show
    @products_count = Product.count(:id)
    @categories_count = Category.count(:id)
  end
end
