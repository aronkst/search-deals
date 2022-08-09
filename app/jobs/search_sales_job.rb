class SearchSalesJob < ApplicationJob
  queue_as :default

  def perform(sale_group_id)
    @sale_group = SaleGroup.find_by!(id: sale_group_id)
    @scraper = @sale_group.scraper

    start
  end

  private

  def start
    browser = Browser.new
    browser.load(@scraper.url)
    html = browser.html

    get_page(html)
    loop_pages(browser, html)

    browser.quit

    @sale_group.finish!
    Rails.logger.debug 'SearchSalesJob: FINISHED'
  end

  def loop_pages(browser, html)
    page = 1

    while page < @scraper.pages
      next_page = get_next_page(html)
      break if next_page.blank?

      next_page = format_url(@scraper.url, next_page)

      browser.load(next_page)
      html = browser.html

      get_page(html)
      page += 1
    end
  end

  def get_page(html)
    parser = Parser.new(html)
    parser.find_many(@scraper.product.tags)

    parser.nodes.each do |node|
      check_sale(node)
    rescue StandardError => e
      Rails.logger.debug "SearchSalesJob: ERROR #{e.inspect}"
      next
    end
  end

  def check_sale(node)
    price = get_price(node.to_s)
    return if price > @scraper.value

    porcentage = 0
    if @scraper.porcentage.present? && @scraper.porcentage.positive?
      sale = get_sale(node.to_s)
      porcentage = calculate_porcentage(sale, price)
      return if porcentage <= 0 || porcentage < @scraper.porcentage
    end

    create_sale(node, price, porcentage)
  end

  def create_sale(node, price, porcentage)
    image = format_url(@scraper.url, get_image(node.to_s))
    title = get_title(node.to_s)
    link = format_url(@scraper.url, get_link(node.to_s))

    Sale.create!(sale_group: @sale_group, title:, value: price, porcentage:, image:, link:)
  end

  def get_value(html, scraper_model)
    parser = Parser.new(html)
    parser.text_one(scraper_model.tags, scraper_model.html, scraper_model.replace)
  end

  def get_price(html)
    scraper_price = @scraper.price
    value = get_value(html, scraper_price)
    value.to_f
  end

  def get_sale(html)
    scraper_sale = @scraper.sale
    value = get_value(html, scraper_sale)
    value.to_f
  end

  def get_image(html)
    scraper_image = @scraper.image
    get_value(html, scraper_image)
  end

  def get_title(html)
    scraper_title = @scraper.title
    get_value(html, scraper_title)
  end

  def get_link(html)
    scraper_link = @scraper.link
    get_value(html, scraper_link)
  end

  def get_next_page(html)
    scraper_next_page = @scraper.next_page
    get_value(html, scraper_next_page)
  end

  def format_url(base_url, url)
    if url[0] == '/'
      uri = URI.parse(base_url)
      url = "#{uri.scheme}://#{uri.host}" + url
    end

    url
  end

  def calculate_porcentage(sale, price)
    return 0 if sale.blank? || sale <= 0

    porcentage = (price * 100) / sale
    porcentage -= 100
    porcentage * -1
  end
end
