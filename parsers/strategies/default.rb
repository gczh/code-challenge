require 'nokolexbor'

class DefaultParserStrategy
  attr_reader :html

  def initialize(html)
    @html = html
  end

  def extract_data
    artworks = []

    doc.css('a.klitem').each do |artwork|
      name = artwork.attr('aria-label')
      link = "https://www.google.com" + artwork.attr('href')
      year = artwork.css('div.ellip.klmeta').text.strip
      image = artwork.css('img')
      image_id = image.attr('id')&.value
      image_src = image_srcs[image_id] if image_id

      artwork = { name: name }
      artwork[:extensions] = [year] unless year.empty?
      artwork.merge!(link: link, image: image_src)

      artworks << artwork
    end

    artworks
  end

  private

  def doc
    @doc ||= Nokolexbor::HTML(html)
  end

  def image_script
    @image_script ||= doc.css('script').find { |script| script.text.include?('_setImagesSrc') }
  end

  def image_srcs
    @image_srcs ||= image_script
                      .text
                      .scan(/var\s*s\s*=\s*'([^']*)'.*?var\s*ii\s*=\s*\['([^']*)'\]/m)
                      .to_h { |s, ii| [ii, s.gsub('\\', '')] }
  end
end
