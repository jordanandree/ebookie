require "spec_helper"

describe Ebookie do

  describe "Version" do
    it "should be present" do
      expect(Ebookie::VERSION).to_not be nil
    end
  end

end