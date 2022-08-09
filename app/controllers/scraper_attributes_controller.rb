class ScraperAttributesController < ApplicationController
  before_action :set_scraper
  before_action :validate_type
  before_action :validate_attribute_product_created
  before_action :set_scraper_attribute, only: %i[show edit update destroy]

  def show; end

  def new
    @scraper_attribute = ScraperAttribute.new
  end

  def edit; end

  def create
    @scraper_attribute = ScraperAttribute.new(scraper_attribute_params)
    @scraper_attribute.scraper = @scraper
    @scraper_attribute.value = params[:value]

    if @scraper_attribute.save
      redirect_to scraper_attribute_url(@scraper, params[:value], @scraper_attribute),
                  notice: "Scraper attribute #{params[:value]} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @scraper_attribute.update(scraper_attribute_params)
      redirect_to scraper_attribute_url(@scraper, params[:value], @scraper_attribute),
                  notice: "Scraper attribute #{params[:value]} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @scraper_attribute.destroy

    redirect_to scraper_url(@scraper), notice: "Scraper attribute #{params[:value]} was successfully destroyed."
  end

  private

  def set_scraper
    @scraper = Scraper.find(params[:scraper_id])
  end

  def set_scraper_attribute
    @scraper_attribute = ScraperAttribute.find_by!(id: params[:id], scraper: @scraper, value: params[:value])
  end

  def validate_type
    return if %w[image link next_page price sale title product].include?(params[:value])

    redirect_to scraper_url(@scraper), notice: 'Attribute is invalid.'
  end

  def validate_attribute_product_created
    return unless @scraper.attribute_product_created? == false && params[:value] != 'product'

    redirect_to scraper_url(@scraper), notice: 'You must create the scraper attribute product before.'
  end

  def scraper_attribute_params
    params.require(:scraper_attribute).permit(:tags, :html, :replace)
  end
end
