module ScrapersHelper
  def attribute_button(scraper, value)
    scraper_attribute = ScraperAttribute.find_by(scraper:, value:)
    if scraper_attribute
      link_to('Show', scraper_attribute_url(scraper, value, scraper_attribute), class: 'btn btn-secondary btn-sm')
    else
      link_to('Create ', new_scraper_attribute_url(scraper, value), class: 'btn btn-primary btn-sm')
    end
  end
end
