require 'spec_helper'

RSpec.describe SoulOwner do
  describe ".env" do
    it "fetches and returns the RACK_ENV" do
      expect(ENV).to receive(:fetch).with('RACK_ENV').and_return('foobar')
      expect(SoulOwner.env).to be == 'foobar'
    end
  end
end