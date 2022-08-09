class SaleGroupsController < ApplicationController
  before_action :set_scraper
  before_action :set_sale_group, only: %i[show destroy]

  def show; end

  def create
    if @scraper.configured?
      sale_group = SaleGroup.create!(scraper: @scraper)
      SearchSalesJob.perform_later(sale_group.id)

      redirect_to sale_groups_show_url(@scraper.id, sale_group.id), notice: 'Search Sales has started.'
    else
      redirect_to root_url, notice: 'Scraper is not yet configured.'
    end
  end

  def destroy
    @sale_group.destroy
    redirect_to root_url, notice: 'Sale Group was successfully destroyed.'
  end

  private

  def set_scraper
    @scraper = Scraper.find_by!(id: params[:scraper_id])
  end

  def set_sale_group
    @sale_group = SaleGroup.find_by!(id: params[:sale_group_id], scraper: @scraper)
  end
end
