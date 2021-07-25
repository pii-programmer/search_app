class ProductsController < ApplicationController
  before_action :search_product, only: [:index, :search]
  def index
    @products = Product.all
    set_product_column
    set_category_column
  end

  def search
    @results = @p.result.includes(:category) #resultメソッドで検索結果を取得(.categoryテーブルも含めてね)し、表示する
  end

  private
  def search_product
    @p = Product.ransack(params[:q]) #検索オブジェクトを生成
  end

  def set_product_column
    @product_name = Product.select("name").distinct # distinctメソッドはDBからレコードを取得する際、重複したものを削除してくれる。
    @product_size = Product.select("size").distinct
    @product_status = Product.select("status").distinct
  end

  def set_category_column
    @category_name = Category.select("name").distinct
  end
end
