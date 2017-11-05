require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension
using SymbolExtension

module Jabverwock

  RSpec.describe 'css test' do
    subject(:aa){A.new}
    
    it "single List" do
      a = A.new
      expect(a.name).to eq "a"
    end

    it "A tag" do
      expect(aa.tgStr).to eq "<a></a>"
    end
    
    
    it "a css" do
      
      j1 = A.new
      j1.css.color("red").font_size(10)
      expect(j1.showCssString).to eq "a {\ncolor: red;\nfont-size: 10;\n}"
    end

    
    it "content add" do
      
      aa.content = "test"
      ans = aa.tgStr
      ans2 = aa.pressVal.showTempleteString
      
      expect(ans).to eq "<a>test</a>"
      expect(ans).to eq ans2
    end
    
    
    it "add label case 1" do

      aa.content = "test" + "a".variable
      ans = aa.press
      ans2 = aa.pressVal.showTempleteString
      
      expect(ans).to eq "<a>test</a>"
      expect(ans).not_to eq ans2 
      
      #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
      #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    end


    it "add symble label case 1" do

      aa.content = "test" + :a.variable
      ans = aa.press
      ans2 = aa.pressVal.showTempleteString
      
      expect(ans).to eq "<a>test</a>"
      expect(ans).not_to eq ans2
                                   
      #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
      #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    end

    
    it "add label case 2" do

      aa.content = "test" + "a".variable
      aa.tgStr
      ans = aa.pressInsert("a".varIs" is done")
      expect(ans).to eq "<a>test is done</a>"

    end

    it "add symble label case 2-1" do

      aa.content = "test" + :a.variable # -> symble
      aa.tgStr
      ans = aa.pressInsert("a".varIs" is done") # -> string
      expect(ans).to eq "<a>test is done</a>"

    end
    
    it "add symble label case 2-2" do

      aa.content = "test" + :a.variable # -> symble
      aa.tgStr
      ans = aa.pressInsert(:a.varIs " is done") # -> symble
      expect(ans).to eq "<a>test is done</a>"

    end
    it "add symble label case 2-3" do

      aa.content = "test" + "a".variable # -> string
      aa.tgStr
      ans = aa.pressInsert(:a.varIs " is done") # -> symble
      expect(ans).to eq "<a>test is done</a>"

    end

    
    it "add label case 3" do

      aa.content = "test" + "a".variable + "-> yes!"
      aa.tgStr
      ans = aa.pressInsert("a".varIs" is done")
      expect(ans).to eq "<a>test is done-> yes!</a>"
      
    end
    
    it "add label case 4, retry insert data" do
      
      aa.content = "test" + "a".variable + "-> yes!"
      aa.tgStr
      ans = aa.pressInsert("a".varIs" is done")
      expect(ans).to eq "<a>test is done-> yes!</a>"

      #retry
      ans2 = aa.pressInsert("a".varIs" was success!")
      expect(ans2).to eq "<a>test was success!-> yes!</a>"
      
    end

    it "add label case 5, no tgStr" do
      
      aa.content = "test" + "a".variable + "-> yes!"
      ans = aa.pressInsert("a".varIs" is done")
      expect(ans).to eq "<a>test is done-> yes!</a>"

      #retry
      ans2 = aa.pressInsert("a".varIs" was success!")
      expect(ans2).to eq "<a>test was success!-> yes!</a>"
      
    end

    
    it "add labels" do

      aa.content = "test" + "a".variable + "b".variable
      aa.tgStr
      i1 = "a".varIs" first"
      i2 = "b".varIs",but..."
      ans = aa.pressInsert(i1,i2)
      expect(ans).to eq "<a>test first,but...</a>"
      
    end
    
    it "href add" do
      aa.tagManager .tagAttr(:href, "http://www")
      ans = aa.tgStr
      expect(ans).to eq"<a href=\"http://www\"></a>"
      
    end

    it "href add improved" do
      aa.attr(:href, "http://www")
      ans = aa.tgStr
      expect(ans).to eq"<a href=\"http://www\"></a>"
      
    end

    it "attr chain" do
      aa.attr(:href, "http://www").attr(:id,"test")
      ans = aa.tgStr
      expect(ans).to eq"<a href=\"http://www\" id=\"test\"></a>"
      
    end

    it "attr target" do
      aa.attr(:target,"http://www")
      ans = aa.tgStr
      
      expect(ans).to eq"<a target=\"http://www\"></a>" 

    end
    
    
  end
end
