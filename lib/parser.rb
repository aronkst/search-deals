class Parser
  attr_reader :nodes

  def initialize(html)
    @nokogiri = Nokogiri::HTML(html)
    @nodes = nil
  end

  def find_one(tags)
    find(tags, true)
    html
  rescue StandardError
    nil
  end

  def find_many(tags)
    find(tags, false)
    html
  rescue StandardError
    nil
  end

  def text_one(tags, value, replace)
    text(tags, value, replace, true)
  rescue StandardError
    nil
  end

  def text_many(tags, value, replace)
    text(tags, value, replace, false)
  rescue StandardError
    nil
  end

  private

  def find(tags, one)
    @nodes = @nokogiri.clone

    tags.split(/\r?\n|\r/).each do |tag|
      next if tag.blank?

      @nodes = @nodes.css(tag)
    end

    @nodes = [@nodes.first] if one
  end

  def html
    value = ''

    @nodes.each do |node|
      value += node.to_s
    end

    value
  end

  def text(tags, value, replace, one)
    one ? find_one(tags) : find_many(tags)

    text = nil

    @nodes.each do |node|
      text = value.blank? ? node.content : node[value]
    end

    text = replace_all(text, replace) if replace.present?
    text
  end

  def replace_all(text, values)
    values = values.split(/\r?\n|\r/).each_slice(2).to_a
    values.each do |value|
      text = text.gsub(value[0], value[1])
    end

    text
  end
end
