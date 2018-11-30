require 'nokogiri'
require 'open-uri'
class ZooplaScraper

  attr_reader :estimated_value, :value_range_lower, :value_range_upper

  def initialize(url)
    css_selector = '.pdp-estimate__price'
    css_selector_value = '.pdp-estimate__range'
    doc = Nokogiri::HTML(open(url))
    @estimated_value = extract_digits(doc.at_css(css_selector).inner_html)
    @value_range_lower, @value_range_upper = doc.at_css(css_selector_value).text.split('-')
    @value_range_lower = extract_digits(@value_range_lower)
    @value_range_upper = extract_digits(@value_range_upper)
  end

  private
    def extract_digits(value)
      value.gsub(/\D/, "")
    end
end
