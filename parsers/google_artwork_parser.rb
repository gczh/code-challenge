require 'json'
require 'selenium-webdriver'
require 'webdrivers'

require_relative 'strategies/default'

class GoogleArtworkParser
  attr_reader :file_path, :parser_strategy_class, :with_selenium

  def initialize(file_path, parser_strategy_class = DefaultParserStrategy, with_selenium = false)
    @file_path = file_path
    @parser_strategy_class = parser_strategy_class
    @with_selenium = with_selenium
  end

  def parse
    html = if with_selenium
      load_html
    else
      File.read(file_path)
    end

    parser_strategy = @parser_strategy_class.new(html)
    artworks = parser_strategy.extract_data

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
