class HomeController < ApplicationController
  def index
    @scrapers = Scraper.all.order(updated_at: :desc)
    @sales_groups = SaleGroup.includes(:scraper).all.order(id: :desc).limit(50)
  end
end
