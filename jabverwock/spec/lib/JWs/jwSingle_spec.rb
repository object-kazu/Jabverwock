require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:pp) { P.new }
    

    it "single List" do
      s = P.new
      expect(s.name ).to eq "p"
    end

    it "JWSingle first test" do
      pp.name = "p"
      expect(pp.tgStr).to eq "<p></p>"

    end
        
    it "content add" do
      pp.name="j"
      pp.content = "test"
      expect(pp.tgStr).to eq "<j>test</j>"
    end

    it "add contentIs" do
      a = P.new.contentIs "this is test"
      expect(a.tgStr).to eq "<p>this is test</p>"
    end

    it "heading class level 1" do
      a = HEADING.new(1).contentIs"this is test"
      expect(a.tgStr).to eq "<h1>this is test</h1>"
    end
    it "heading class level 2" do
      a = HEADING.new(2).contentIs"this is test"
      expect(a.tgStr).to eq "<h2>this is test</h2>"
    end
    
    
  end
end
