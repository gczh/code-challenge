require 'nokogiri'
require 'json'
require 'pry'
require 'open-uri'
require 'selenium-webdriver'
require 'webdrivers'

require_relative 'strategies/default'

class GoogleArtworkParser
  attr_reader :file_path, :parser_strategy

  def initialize(file_path, parser_strategy = DefaultParserStrategy.new)
    @file_path = file_path
    @parser_strategy = parser_strategy
  end

  def parse
    html = load_html
    doc = Nokogiri::HTML(html)
    artworks = parser_strategy.extract_data(doc)

    save_to_json(artworks)
  end

  private

  def load_html
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options

    html_file = 'file://' + File.expand_path(file_path)
    driver.get(html_file)
    html = driver.page_source
    driver.quit

    html
  end

  def save_to_json(artworks)
    output_path = 'temp/output-array.json'
    json_output = JSON.pretty_generate({ artworks: artworks })

    FileUtils.mkdir_p(File.dirname(output_path))
    File.write(output_path, json_output)
  end
end
