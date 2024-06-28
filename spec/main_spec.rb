describe GoogleArtworkParser do
  let(:file_path) { 'spec/fixtures/van-gogh-paintings.html' }
  let(:output_file) { 'temp/output-array.json' }
  let(:parser_strategy_class) { DefaultParserStrategy }

  subject { described_class.new(file_path, parser_strategy_class, with_selenium).parse }

  before do
    # Ensure the output file is removed before each test
    File.delete(output_file) if File.exist?(output_file)
  end

  context "when with_selenium is false" do
    let(:with_selenium) { false }

    it "extracts the artworks to a file" do
      subject

      expect(File).to exist(output_file)

      parsed_output = JSON.parse(File.read(output_file))
      expect(parsed_output['artworks'].length).to be > 0
    end
  end

  context "when with_selenium is true" do
    let(:with_selenium) { true }

    it "extracts the artworks to a file" do
      subject

      expect(File).to exist(output_file)

      parsed_output = JSON.parse(File.read(output_file))
      expect(parsed_output['artworks'].length).to be > 0
    end
  end
end
