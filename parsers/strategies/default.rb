class DefaultParserStrategy
  def extract_data(doc)
    artworks = []
    doc.css('a.klitem').each do |artwork|
      name = artwork.attr('aria-label')
      link = "https://www.google.com" + artwork.attr('href')
      image = artwork.css('img').attr('src')&.value
      year = artwork.css('div.ellip.klmeta').text.strip

      artwork = { name: name }
      artwork[:extensions] = [year] unless year.empty?
      artwork.merge!(link: link, image: image)

      artworks << artwork
    end

    artworks
  end
end