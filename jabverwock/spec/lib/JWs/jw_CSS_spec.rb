require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:jwcss) { JW_CSS.new }    
    
    it 'is test for global' do
      expect(jwcss.name).to eq 'jw_css' 
    end

    it 'jwCss style with name test' do
      jwcss.cssWithName "p"
      jwcss.css.color = "red"
      expect(jwcss.css.str).to eq "p {\ncolor: red;\n}"
    end

    it 'jwCss style, symbole allow use' do
      jwcss.cssWithName :p
      jwcss.css.color = :red
      expect(jwcss.css.str).to eq "p {\ncolor: red;\n}"
    end
    
    it 'jwCss css with chain' do
      jwcss.cssWithName :p
      jwcss.css.color(:red).font_size(10)
      expect(jwcss.css.str).to eq "p {\ncolor: red;\nfont-size: 10;\n}"
       
    end

    it 'cssArray add css case 2' do
      c = CSS.new("p")
      b = CSS.new("b")
      ca = [c,b]
      jwcss.cssAssemble(c, ca)
      expect(jwcss.cssString).to eq ""
    end

    it 'isExistCssString' do
      c = CSS.new "p"
      ans = KString.isExistCssString c.removeNameFlags
      expect(ans).to eq false

      
    end

    it 'isExistCssString case 2' do
      a = "p {\n\n}"
      ans = KString.isExistCssString a
      expect(ans).to eq false

       a = "p"
       ans = KString.isExistCssString a
       expect(ans).to eq false
      
       a = "jw_css {\n" + "\n" + "}"
       ans = KString.isExistCssString a
       expect(ans).to eq false
              
  #      ### false ### with style
       a = "p {aaa}"
       ans = KString.isExistCssString a
       expect(ans).to eq true
       
       a = "p {aa}"
       ans = KString.isExistCssString a
       expect(ans).to eq true
       
       a = "p {\nfont-size: 10;\n}"
       ans = KString.isExistCssString a
       expect(ans).to eq true
      
    end

    it 'cssArray add css' do
      c = CSS.new("p").font_size(10)      
      b = CSS.new("b")
      ca = [c,b]
      jwcss.cssAssemble(c,ca)
      expect(jwcss.cssString).to eq "p {\nfont-size: 10;\n}\n"
      
    end

    it 'cssArray add css case 2'do
      c = CSS.new(:p).font_size(10)
      b = CSS.new("b").color("red")
      ca = [c,b]
      jwcss.cssAssemble(c, ca)
      expect(jwcss.cssString).to eq "p {\nfont-size: 10;\n}\nb {\ncolor: red;\n}\n"      
    end

    it 'isSameCSSName, same CSS do not use ' do
      c = CSS.new("p").font_size(10)
      b = CSS.new("p").color("red")
      ca = [c,b]
      jwcss.cssAssemble(c, ca)
      expect(jwcss.cssString).to eq "p {\nfont-size: 10;\n}\n"
    end

    it "add member, do not use same name" do
      
      j1 = JW_CSS.new
      j1.css.color("red").font_size(10)
      
      j2 = JW_CSS.new
      j2.cssWithName("p")
      j2.css.font_style("bold")

      j1.addMember j2
      expect(j1.showCssString).to eq "jw_css {\ncolor: red;\nfont-size: 10;\n}\np {\nfont-style: bold;\n}"
    end

    it "add member,same name" do
      
      j1 = JW_CSS.new
      j1.css.color(:red).font_size(10)
      
      j2 = JW_CSS.new
      j2.css.font_style(:bold)

      j1.addMember j2

      expect(j1.showCssString).to eq "jw_css {\ncolor: red;\nfont-size: 10;\n}"
      
    end

    it "add members" do
      
      j1 = JW_CSS.new
      j1.css.color("red")

      j2 = JW_CSS.new
      j2.cssWithName("p")
      j2.css.font_style("bold")
      
      j3 = JW_CSS.new
      j3.cssWithName("b")
      j3.css.font_size(10)
        
      j1.addMembers(j2, j3)
      
      expect(j1.showCssString).to eq "jw_css {\ncolor: red;\n}\np {\nfont-style: bold;\n}\nb {\nfont-size: 10;\n}"
          
    end

    it "add css, caution!, because jw class and css class sometimes has different name" do
      j1 = JW_CSS.new
      
      c = CSS.new "t"
      c.font_size(10)
      
      j1.addCss c

      expect(j1.showCssString).to eq "t {\nfont-size: 10;\n}"
    end
        
    it "add css, when set css name void, name is same as class" do
      j1 = JW_CSS.new
      
      c = CSS.new ""
      c.font_size(10)
      
      j1.addCss c

      expect(j1.showCssString).to eq  "jw_css {\nfont-size: 10;\n}"
    end


    it "export css style case true" do
      j = JW_CSS.new
      h = HEAD.new.contentIs "headsss"
            
      j.addMember h
      
      c = CSS.new ""
      c.font_size(10)
      
      j.addCss c
      expect(j.tgStr.include?("style")).to eq true
      
    end

    it "export css style case2 true" do
      j = JW_CSS.new
      h = HEAD.new.contentIs "headsss"
      
      c = CSS.new ""
      c.font_size(10)      
      h.addCss c
      
      j.addMember h
      expect(j.tgStr.include?("style")).to eq true
      
    end
    
    it "export css style case3 true" do
      j = JW_CSS.new
      
      h = HEAD.new.contentIs "headsss"
      h.css.font_size 10
      j.addMember h
      
      expect(j.tgStr.include?("style")).to eq true
      
    end
    
    it "export css style case false" do
      j = JW_CSS.new
      pp = JW_CSS.new
      j.addMember pp
      
      c = CSS.new ""
      c.font_size(10)
      
      j.addCss c      
      expect(j.tgStr.include?("style")).to eq false
      
    end

    
    
    
  end
end

    
    


    

    
