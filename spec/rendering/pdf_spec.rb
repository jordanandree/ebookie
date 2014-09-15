require "spec_helper"

describe Ebookie::Rendering::PDF do
  let(:document) { Ebookie::Document.new("My Book") }
  let(:pdf) { Ebookie::Rendering::PDF.new(document) }

  it "should return false for template?" do
    expect(pdf.template?).to be false
  end

end