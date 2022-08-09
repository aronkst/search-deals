class Scraper < ApplicationRecord
  validates :name, :url, :pages, :value, :porcentage, :html, presence: true
  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :porcentage, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  before_validation :set_html

  has_many :scraper_attributes, dependent: :destroy
  has_many :sale_groups, dependent: :destroy

  def attribute_product_created?
    scraper_attributes.exists?(value: 'product')
  end

  def html_code_product
    scraper_attribute_product = scraper_attributes.find_by!(value: 'product')
    parser = Parser.new(html)
    parser.find_one(scraper_attribute_product.tags)
  end

  def configured?
    scraper_attributes.count == if porcentage.blank? || porcentage <= 0
                                  6
                                else
                                  7
                                end
  end

  def product
    scraper_attributes.find_by!(value: 'product')
  end

  def image
    scraper_attributes.find_by!(value: 'image')
  end

  def link
    scraper_attributes.find_by!(value: 'link')
  end

  def next_page
    scraper_attributes.find_by!(value: 'next_page')
  end

  def price
    scraper_attributes.find_by!(value: 'price')
  end

  def sale
    scraper_attributes.find_by!(value: 'sale')
  end

  def title
    scraper_attributes.find_by!(value: 'title')
  end

  def clone
    return nil unless configured?

    clone_scraper = dup
    clone_scraper.save

    scraper_attributes.each do |attribute|
      clone_attribute = attribute.dup
      clone_attribute.scraper = clone_scraper
      clone_attribute.save
    end

    clone_scraper
  end

  private

  def set_html
    return if url.blank?

    browser = Browser.new
    browser.load(url)
    self.html = browser.html
    browser.quit
  end
end
