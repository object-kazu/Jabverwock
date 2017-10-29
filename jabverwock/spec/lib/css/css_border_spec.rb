require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:css){CSS.new "t"}
    
    it "property border" do
      css.name = "head"
      css.border = "10px solid"
      css.border_left = "1px solid"
      expect(css.str).to eq  "head {\nborder: 10px solid;\nborder-left: 1px solid;\n}"
    end

    it 'property border width' do
      css.name = "head"
      css.border_width = "1px solid"
      expect(css.str).to eq  "head {\nborder-width: 1px solid;\n}"
    end

    it 'property border top-width' do
      css.name = 'head'
      css.border_top_width = '2px'
      expect(css.str).to eq  "head {\nborder-top-width: 2px;\n}"     
    end


    it 'property border style' do
      css.name = 'head'
      css.border_style = STYLE.NONE
      expect(css.str).to eq  "head {\nborder-style: none;\n}"
    end
    
    it 'property border style case 2' do
      css.name = 'head'
      css.border_style = STYLE.DOTTED
      expect(css.str).to eq  "head {\nborder-style: dotted;\n}"
    end

    it 'property border color' do
      css.name = 'head'
      css.border_color = "red blue red green"
      expect(css.str).to eq  "head {\nborder-color: red blue red green;\n}"
    end
    
  end  
end
