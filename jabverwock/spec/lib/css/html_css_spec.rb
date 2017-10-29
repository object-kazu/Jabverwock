require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:css){CSS.new "t"}
    
     it "set css property" do
      h = HEAD.new().contentIs "this is test"
      h.css.font_size = 10
      expect(h.css.str).to eq  "head {\nfont-size: 10;\n}"
    end
    
    it "set css property case 2" do
      h = HEAD.new().contentIs "this is test"
      h.css.font_size("10")
      expect(h.css.str).to eq  "head {\nfont-size: 10;\n}"
    end
    
    it "add css property not" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head .exp #cls"
      c.font_size = 10
      h.addCss c
      a = h.showCssString
      
      expect(a).to eq  "head .exp #cls {\nfont-size: 10;\n}"
    end
    
    it "add css property , different name" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "p"
      c.font_size = 10

      
      h.addCss c
      a = h.showCssString
      
      expect(a).to eq  "p {\nfont-size: 10;\n}"
    end

    
    it "add css property" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      pressed = h.tgStr
      
      expect(pressed.include?("<style>\n")).to eq true
      expect(pressed.include?("head {\nfont-size: 10;\n}\n")).to eq true
      expect(pressed.include?("</style>")).to eq true
      
   end

    
    it "add member " do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      body = BODY.new
      body.css.color "red"

      h.addMember body
      
      pressed = h.tgStr

    expect(pressed.include?("<style>\n")).to eq true 
    expect(pressed.include?("head {\nfont-size: 10;\n}\n")).to eq true 
    expect(pressed.include?("body {\ncolor: red;\n}\n")).to eq true 
    expect(pressed.include?("</style>")).to eq true 

    end
    
    
  end  
end
