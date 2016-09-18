# frozen_string_literal: true
require "spec_helper"

describe Ebookie::Document::Chapter do
  let(:chapter) { Ebookie::Document::Chapter.new("My Book", "foo") }

  describe "::initialize class method" do
    it "should take a title argument" do
      expect(chapter.title).to eq "My Book"
    end

    it "should take a content argument" do
      expect(chapter.content).to eq "foo"
    end
  end

  describe "#content instance method" do
    context "when @content is a Pathname" do
      it "should return the file contents" do
        chapter = Ebookie::Document::Chapter.new("My Book", Pathname.new("Gemfile"))
        expect(chapter.content).to match %r{source 'https://rubygems}
      end
    end

    context "when @content is a string" do
      it "should return the string" do
        expect(chapter.content).to eq "foo"
      end
    end
  end

  describe "#slug instance method" do
    it "should return the formatted title string" do
      expect(chapter.slug).to eq "my-book"
    end
  end
end
