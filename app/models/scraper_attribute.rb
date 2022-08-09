class ScraperAttribute < ApplicationRecord
  validates :scraper, :tags, :value, presence: true
  validates :value, inclusion: { in: %w[image link next_page price sale title product] }
  validates :value, uniqueness: { scope: :scraper }

  belongs_to :scraper

  def html_code
    if value == 'product'
      scraper.html_code_product
    else
      html_text = value == 'next_page' ? scraper.html : scraper.html_code_product
      parser = Parser.new(html_text)
      parser.find_one(tags)
    end
  end

  def html_value
    if value == 'product'
      nil
    else
      html_text = value == 'next_page' ? scraper.html : scraper.html_code_product
      parser = Parser.new(html_text)
      parser.text_one(tags, html, replace)
    end
  end
end
