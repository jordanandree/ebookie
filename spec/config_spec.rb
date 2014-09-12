require "spec_helper"

describe Ebookie::Document::Config do
  let(:config) { Ebookie::Document::Config.new }

  describe "#date option" do
    it "should have default" do
      expect(config.date).to eq Time.now.strftime("%F")
    end

    it "can be overridden" do
      config.date = Time.now.to_i
      expect(config.date).to be_a Integer
    end
  end

  describe "#date option" do
    it "should have default" do
      expect(config.language).to eq 'en-US'
    end

    it "can be overridden" do
      config.language = 'en-GB'
      expect(config.language).to eq 'en-GB'
    end
  end

end