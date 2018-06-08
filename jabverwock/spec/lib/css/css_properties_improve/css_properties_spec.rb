require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
     subject(:css) { CSS.new }
     
     # div.css.name = sym
     # div.css.width("400px").height("400px").position("relative").background("yellow")

    it "property default method, not chain" do
      css.name = "head"
      css.font_size = 10
      css.color = "red"
      expect(css.str).to eq "head {\nfont-size: 10;\ncolor: red;\n}"
    end

    it "name check" do
      css.name = ""
      expect{css.str}.to raise_error (RuntimeError)
    end
    
    it "property default method closure" do
      ha = { name: "head", font_size: 10, color: "red" }
      css.properties ha
      expect(css.str).to eq "head {\nfont-size: 10;\ncolor: red;\n}"
    end
    
  end
end
      
      
