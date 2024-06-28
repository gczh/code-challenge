describe GoogleArtworkParser do
  let(:file_path) { 'spec/fixtures/van-gogh-paintings.html' }
  let(:output_file) { 'temp/output-array.json' }

  subject { described_class.new(file_path).parse }

  before do
    # Ensure the output file is removed before each test
    File.delete(output_file) if File.exist?(output_file)
  end

  it "extracts the artworks to a file" do
    subject

    # Debugging output
    # puts "Checking if file exists: #{output_file}"
    # puts "Current directory: #{Dir.pwd}"
    # puts "Files in output directory: #{Dir['*']}"

    expect(File).to exist(output_file)

    parsed_output = JSON.parse(File.read(output_file))
    expect(parsed_output['artworks'].length).to be > 0
  end
end
