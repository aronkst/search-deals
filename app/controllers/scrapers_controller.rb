class ScrapersController < ApplicationController
  before_action :set_scraper, only: %i[show edit update destroy clone]

  def index
    @scrapers = Scraper.all.order(updated_at: :desc)
  end

  def show; end

  def new
    @scraper = Scraper.new
  end

  def edit; end

  def create
    @scraper = Scraper.new(scraper_params)
    if @scraper.save
      redirect_to scraper_url(@scraper), notice: 'Scraper was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @scraper.update(scraper_params)
      redirect_to scraper_url(@scraper), notice: 'Scraper was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @scraper.destroy
    redirect_to scrapers_url, notice: 'Scraper was successfully destroyed.'
  end

  def clone
    clone_scraper = @scraper.clone
    redirect_to scraper_url(clone_scraper), notice: 'Scraper was successfully cloned.'
  end

  private

  def set_scraper
    @scraper = Scraper.find(params[:id])
  end

  def scraper_params
    params.require(:scraper).permit(:name, :url, :pages, :value, :porcentage, :html)
  end
end
