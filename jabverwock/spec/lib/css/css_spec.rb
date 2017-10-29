require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
     subject(:css) { CSS.new "t" }
    

    it "set property" do
      css.name = "head"
      css.font_size = 10
      expect{
        css.gogo(1) # no property
      }.to raise_error StandardError

    end

    
    it "insert property class" do
      css.name = "head"
      css.font_size = 10
      expect(css.str).to eq "head {\nfont-size: 10;\n}"
    end

    it "property default method, not chain" do
      css.name = "head"
      css.font_size = 10
      css.color = "red"
      expect(css.str).to eq "head {\nfont-size: 10;\ncolor: red;\n}"
    end

    it "property method chain" do      
      css.name = "head"
      css.font_size("10").color("red")
      expect(css.str).to eq "head {\nfont-size: 10;\ncolor: red;\n}"
    end

    it "name divide by space" do
      
      css.name = "head .cls"
      css.font_size("10").color("red").font_style("bold")
      expect(css.str).to eq "head .cls {\nfont-size: 10;\ncolor: red;\nfont-style: bold;\n}"

    end

    it "css name define" do
      c = CSS.new("head")
      c.font_size("10").color("red").font_style("bold")
      expect(c.str).to eq "head {\nfont-size: 10;\ncolor: red;\nfont-style: bold;\n}"
    end

    it "css name symbole case 1" do
      c = CSS.new :head
      c.font_size("10").color("red").font_style("bold")
      expect(c.str).to eq "head {\nfont-size: 10;\ncolor: red;\nfont-style: bold;\n}"
    end

    it "combineSelectors" do
      c = CSS.new "ss,s,h"
      expect(c.name).to eq "ss,s,h"
    end
    

    # # dpName, addChildrenName, addMembersName
    
    it 'dpName' do
      c = CSS.new :head
      c2 = c.dpName
      expect(c2).to eq "head"
    end

    it 'dpName import' do
      c = CSS.new :head
      c2 = CSS.new c.dpName
      expect(c2.name).to eq 'head'
    end
    
    it "dup and addChildren" do
      c = CSS.new :head
      c2 = CSS.new c.addChildrenName "p"

      expect(c.name).to eq "head"
      expect(c2.name).to eq "head p"
    end

    it "dup and addMembers" do
      c = CSS.new :head
      c2 = CSS.new c.addMembersName "p"

      expect(c.name).to eq "head"
      expect(c2.name).to eq "head, p"
    end

    it "dpName and css property" do
      c = CSS.new(:head).color "red"
      c2 = CSS.new c.addChildrenName "p"
      c2.color("yellow")

      expect(c.str).to eq "head {\ncolor: red;\n}"
      expect(c2.str).to eq "head p {\ncolor: yellow;\n}"
    end

    # #css symbole name
    it 'symbol Name id' do
      c = CSS.new(:id__test).color "red"
      expect(c.str).to eq "#test {\ncolor: red;\n}"
      
    end
    
    it 'symbol Name class' do
      c = CSS.new(:cls__test).color "red"
      expect(c.str).to eq ".test {\ncolor: red;\n}"
      
    end
      
    it 'symbol Name just symbol ' do
      c = CSS.new(:a__test).color "red"
      expect(c.str).to eq "atest {\ncolor: red;\n}"
    end

    it 'symbol Name property' do
      c = CSS.new("").color "red"
      c.name = :id__test
      expect(c.str).to eq "#test {\ncolor: red;\n}"
    end

   
    
  end  
end
