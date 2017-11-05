require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'B tag test' do
    subject(:bb){B.new}
    
    it "single List" do
      a = B.new
      expect(a.name ).to eq "b"
    end

    it "B tag" do
      ans = bb.press
      expect(ans).to eq "<b></b>"
    end
    
    
    it "b css" do
      
      j1 = B.new
      j1.css.color("red").font_size(10)
      expect(j1.showCssString).to eq "b {\ncolor: red;\nfont-size: 10;\n}"
    end

    
    it "content add" do
      
      bb.content = "test"
      ans = bb.press
      ans2 = bb.pressVal.showTempleteString
      
      expect(ans).to eq "<b>test</b>"
      expect(ans).to eq ans2
    end
    
    
    it "add label case 1" do

      bb.content = "test" + "a".variable
      ans = bb.press
      ans2 = bb.pressVal.showTempleteString
      
      expect(ans).to eq "<b>test</b>"
      expect(ans).not_to eq ans2
      
      #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
      #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    end

    
    it "add label case 2" do

      bb.content = "test" + "a".variable
      bb.press
      ans = bb.pressInsert("a".varIs" is done")
      expect(ans).to eq "<b>test is done</b>"

    end
    
    it "add label case 3" do

      bb.content = "test" + "a".variable + "-> yes!"
      bb.press
      ans = bb.pressInsert("a".varIs" is done")
      expect(ans).to eq "<b>test is done-> yes!</b>"
      
    end
    
    it "add label case 4, retry insert data" do
      
      bb.content = "test" + "a".variable + "-> yes!"
      bb.press
      ans = bb.pressInsert("a".varIs" is done")
      expect(ans).to eq "<b>test is done-> yes!</b>"

      #retry
      ans2 = bb.pressInsert("a".varIs" was success!")
      expect(ans2).to eq "<b>test was success!-> yes!</b>"
      
    end

    it "add labels" do

      bb.content = "test" + "a".variable + "b".variable
      bb.press
      i1 = "a".varIs" first"
      i2 = "b".varIs",but..."
      ans = bb.pressInsert(i1,i2)
      expect(ans).to eq "<b>test first,but...</b>"
      
    end
    
    it "href add" do
      bb.tagManager .tagAttr(:href, "http://www")
      ans = bb.press
      expect(ans).to eq"<b href=\"http://www\"></b>"
      
    end

    it "href add improved" do
      bb.attr(:href, "http://www")
      ans = bb.press
      expect(ans).to eq"<b href=\"http://www\"></b>"
      
    end

    it "attr chain" do
      bb.attr(:href, "http://www").attr(:id,"test")
      ans = bb.press
      expect(ans).to eq"<b href=\"http://www\" id=\"test\"></b>"
      
    end

    it "attr target" do
      bb.attr(:target,"http://www")
      ans = bb.press
      
      expect(ans).to eq"<b target=\"http://www\"></b>"
      
    end
    
    
  end
end
