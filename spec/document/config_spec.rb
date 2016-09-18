# frozen_string_literal: true
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
      expect(config.language).to eq "en-US"
    end

    it "can be overridden" do
      config.language = "en-GB"
      expect(config.language).to eq "en-GB"
    end
  end

  describe "setting a cover" do
    it "should set file if it exists" do
      config.cover = "./spec/fixtures/sample.png"
      expect(config.cover).to be_a Pathname
    end

    it "should set file if type is pdf" do
      config.cover = "./spec/fixtures/sample-2.pdf"
      expect(config.cover).to be_a Pathname
    end

    it "should not set file if it doesnt exist" do
      config.cover = "./spec/fixtures/missing.png"
      expect(config.cover).to_not be_a Pathname
    end

    it "should not set file if files is not a png" do
      config.cover = "./spec/fixtures/sample.jpg"
      expect(config.cover).to_not be_a Pathname
    end
  end

  describe "#template" do
    it "can be set to custom template directory" do
      FileUtils.mkdir_p "./tmp/template"
      config.template = "./tmp/template"
      expect(config.template.to_s).to match %r{tmp/template}
    end
  end
end
