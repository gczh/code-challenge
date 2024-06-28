require 'rspec'
require 'nokolexbor'
require_relative '../parsers/strategies/default'

RSpec.describe DefaultParserStrategy, "#extract_data" do
  let(:html) { File.read('./files/van-gogh-paintings.html') }
  let(:parser) { DefaultParserStrategy.new(html) }
  let(:doc) { Nokolexbor::HTML(html) }
  let(:artworks) { parser.extract_data }

  context "when the artworks are extracted" do
    it "returns an array" do
      expect(artworks).to be_a(Array)
    end

    it "each artwork object has a name attribute of type string" do
      artworks.each do |artwork|
        expect(artwork[:name]).to be_a(String)
      end
    end

    it "each artwork object has an extensions attribute of type array or nil" do
      artworks.each do |artwork|
        expect(artwork[:extensions]).to be_a(Array).or(be_nil)
      end
    end

    it "each artwork object has a link attribute of type string" do
      artworks.each do |artwork|
        expect(artwork[:link]).to be_a(String)
      end
    end

    it "each artwork object has an image attribute of type string or nil" do
      artworks.each do |artwork|
        expect(artwork[:image]).to be_a(String).or(be_nil)
      end
    end
  end
end
