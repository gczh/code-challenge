require_relative 'parsers/google_artwork_parser'

parser = GoogleArtworkParser.new('files/van-gogh-paintings.html')
parser.parse
