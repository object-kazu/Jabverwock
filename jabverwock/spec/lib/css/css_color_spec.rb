require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:css){CSS.new "t"}
    
    it "property default method, not chain" do
      css.name = "head"
      css.font_size = 10
      css.color = "red"
      expect(css.str).to eq  "head {\nfont-size: 10;\ncolor: red;\n}"
    end

    it "property method chain" do      
      css.name = "head"
      css.font_size("10").color("red")

      expect(css.str).to eq  "head {\nfont-size: 10;\ncolor: red;\n}"
    end


    it 'color expression #00ff00' do
      css.name = "head"
      css.font_size("10").color(Color.rgb(255,0,0))

      expect(css.str).to eq  "head {\nfont-size: 10;\ncolor: rgb(255, 0, 0);\n}"
      
    end
    
  end  
end
