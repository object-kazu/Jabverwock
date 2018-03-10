require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:jws) { JWS.new }    
    it 'is test for global' do
      expect(jws.name).to eq 'jws' 
    end    
  end

  RSpec.describe 'insert variable' do
    # subject(:jws){JWS.new}
    
    it 'countArrayDepth 'do
      arr =
        ["a",
         "b",
         ["aa",
          "bb"],
         ["cc",
          "cdd"],
         "c"
        ]

      ans = JWS.countArrayDepth arr
      expect(ans[0]).to eq :index0 => "a"
    end

    it 'countArrayDepth with P tag' do
      p1 = P.new.contentIs "this is test1"
      p2 = P.new.contentIs "this is test2"
      arr =
        [
          p1,
          p2
          
        ]

      ans = JWS.countArrayDepth arr
      expect(ans[0]).to eq :index0 => p1
    end

    it 'countArrayDepth with HTML and P tag' do
      html = HTML.new
      p1 = P.new.contentIs "this is test1"
      arr =
        [
          html,
          [p1]
          
        ]

      ans = JWS.countArrayDepth arr
      expect(ans[0]).to eq :index0 => html
      expect(ans[1]).to eq :index1 => p1
    end

    it 'countArrayDepth with head, title and body  tag' do
      header = HEADER.new
      title = TITLE.new.contentIs "this is test1"
      body = BODY.new
      arr =
        [
          header,
          [title],
          body
          
        ]

      ans = JWS.countArrayDepth arr
      expect(ans[0]).to eq :index0 => header
      expect(ans[1]).to eq :index1 => title
      expect(ans[2]).to eq :index0 => body
    end

    
    it 'is a JW class' do
      p1 = P.new.contentIs "this is test1"
      ans = JWS.transrate p1
      expect(ans).to eq "<p>this is test1</p>"
    end

    it 'is not a JW class' do
      ans = JWS.transrate "a"
      expect(ans).to eq nil
    end

    it 'build' do
      p1 = P.new.contentIs "this is test1"
      p2 = P.new.contentIs "this is test2"
      ans = JWS.build [p1,p2]
      expect(ans).to eq "<p>this is test1</p>\n<p>this is test2</p>"
    end

    it 'addTab' do
      test = "test"
      ans = JWS.addTab test, 1
      expect(ans).to eq "\ttest"
    end

    it 'extractTabNumber' do
      num = JWS.extractTabNumber :index1
      expect(num).to eq 1
    end

    it 'tabbing' do
      tes = {:index1 => "body"}
      ans = JWS.tabbing tes
      expect(ans).to eq "\tbody"
    end
    
    # it 'JW, isSingle method'do
    #   ans = jw.isSingleTag(true)
    #   expect(ans).to be true
    # end

    # it 'JW, isSingle method nil' do
    #   ans = jw.isSingleTag 1
    #   expect(ans).to be nil
    # end

    # it 'pretest: pressDefault, nothing' do
    #   p jw.pressVal.initResutString
    #   expect(jw.pressVal.resultString).to eq ""
    # end

    # it 'assemble' do
    #   jw.name = 'test'
    #   expect(jw.tgStr).to eq "<test>\n</test>"
    # end

    # it 'assemble, bad Arg' do
    #   expect{
    #     jw.setName = 1
    #   }.to raise_error(NoMethodError)
      
    # end

    # it 'set cls ' do
    #   jw.name='p'
    #   jw.attr(:cls, 'test')
    #   expect(jw.tgStr).to eq "<p class=\"test\">\n</p>"
    # end

    # it 'set cls, bad arg' do
    #   expect{
    #     jw.setCls = 1
    #   }.to raise_error(NoMethodError)
    # end

    # it 'get id and cls' do
    #   jw.name = 'test'
    #   jw.attr(:cls, 'sample').attr(:id,'dada')
    #   expect(jw.tgStr).to eq "<test class=\"sample\" id=\"dada\">\n</test>"
    # end

    # it 'get id and cls case 2' do
    #   jw.name = 'test'
    #   jw.attrSymbol :cls__sample
    #   jw.attrSymbol :id__data
    #   expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\">\n</test>"
    # end
    
    # it 'get id and cls case 3-1'do
    #   jw.name  = 'test'
    #   jw.attrSymbol :cls__sample
    #   expect(jw.tgStr).to eq  "<test class=\"sample\">\n</test>"
    # end

    # it 'get id and cls case 3-2'do

    #   jw.name = 'test'
    #   jw.attr(:cls__sample, :id__data)
    #   expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\">\n</test>"
    # end
    

    # it 'get id and cls case 4'do
    #   jw.name = 'test'
    #   jw.attr(:cls__sample, :id__data, :name, 'test')
    #   expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\" name=\"test\">\n</test>"
    # end

    # it 'get id and cls error case' do
    #   jw.name = 'test'
    #   jw.attr(:cls__sample, :id__data, :name) #ignore :name
    #   expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\">\n</test>"
    # end

    # it 'get id and cls error case 2'do
    #   jw.name = 'test'
    #   jw.attr(:cls__sample, :id__data, 'name') #ignore 'name'
    #   expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\">\n</test>"
    # end

    # it 'add lang ' do
    #   jw.name = 'p'
    #   jw.attr(:lang__en)
    #   expect(jw.tgStr).to eq "<p lang=\"en\">\n</p>"
    # end

    # it 'add it' do
    #   jw.name = 'p'
    #   jw.attr :id__sample
    #   expect(jw.tgStr).to eq "<p id=\"sample\">\n</p>"
    # end

    # it 'attr bind with' do
    #   j = JW.new.attr :id__sample
    #   expect(j.tgStr).to eq "<jw id=\"sample\">\n</jw>"
    # end
    
    # it 'attr: replace _to -' do
    #   j = JW.new.attr(:font_size, '10')
    #   expect(j.tgStr).to eq "<jw font-size=\"10\">\n</jw>"
    # end

    # it 'attr bind with __ case 2' do
    #   j = JW.new.attr(:font_size__10)
    #   expect(j.tgStr).to eq "<jw font-size=\"10\">\n</jw>"
       
    # end

    # it 'set cls use symbol'do
    #   jw.name = 'p'
    #   jw.attr :cls__test
    #   expect(jw.tgStr).to eq  "<p class=\"test\">\n</p>"
    # end

    # it 'set cls no use symbol 'do
    #   jw.name = 'p'
    #   jw.attr :cls
    #   expect(jw.tgStr).to eq  "<p>\n</p>"
    # end

    # it 'attrWithSymbolsArray'do
    #   jw.name = 'p'
    #   arr = [:id__test, :cls__sample]
    #   jw.attrWithSymbolsArray arr
    #   expect(jw.tgStr).to eq "<p id=\"test\" class=\"sample\">\n</p>"
    # end
    
  end
  
end   

