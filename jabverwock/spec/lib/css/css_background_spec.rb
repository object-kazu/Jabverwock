require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:css){CSS.new "t"}
    
    it "property background_color" do
      css.name = "head"
      css.background_color = "red"
      expect(css.str).to eq  "head {\nbackground-color: red;\n}"
    end

    it 'property background_image' do

      css.name = 'head'
      css.background_image = URL.url 'paper.gif'.dQuo
       expect(css.str).to eq  "head {\nbackground-image: url(\"paper.gif\");\n}"
    end

    it 'property background_repeat, repeat' do
      css.name = 'head'
      css.background_repeat = REPEAT.Yes.val
      expect(css.str).to eq  "head {\nbackground-repeat: repeat;\n}"
      
    end

    it 'property background_repeat, repeat-x, repeat-y' do
      css.name = 'head'
      css.background_repeat = REPEAT.X.Y.val
      expect(css.str).to eq  "head {\nbackground-repeat: repeat-x repeat-y;\n}"  
    end

    
    it 'property background_attachment' do
      css.name = 'head'
      css.background_attachment = ATTATCHMENT.SCROLL
       expect(css.str).to eq  "head {\nbackground-attachment: scroll;\n}"
      
    end

    it 'property background_attachment local' do
      css.name = 'head'
      css.background_attachment = ATTATCHMENT.LOCAL
       expect(css.str).to eq  "head {\nbackground-attachment: local;\n}"
      
    end

    it 'property background_position' do
      css.name = 'head'
      css.background_position = "left"
      expect(css.str).to eq  "head {\nbackground-position: left;\n}"
      
    end

    it 'property background_origin' do
      css.name = 'head'
      css.background_origin = ORIGIN.BORDER
      expect(css.str).to eq  "head {\nbackground-origin: border-box;\n}"
    end

    it 'property background_size' do
      css.name = 'head'
      css.background_size = "50px 50px"
      expect(css.str).to eq  "head {\nbackground-size: 50px 50px;\n}"      
    end
    
  end  
end
