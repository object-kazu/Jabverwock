require 'spec_helper'
require_relative '../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:jw) { JW.new }    
    it 'is test for global' do
      expect(jw.name).to eq 'jw' 
    end    
  end

  RSpec.describe 'insert variable' do
    subject(:jw){JW.new}
    
    it 'pretest for varibale 'do
      a = 'a'.varIs('aa')
      expect(a[:label]).to eq "a"
      expect(a[:data]).to eq 'aa'
    end


    it 'JW, isSingle method'do
      ans = jw.isSingleTag(true)
      expect(ans).to be true
    end

    it 'JW, isSingle method nil' do
      ans = jw.isSingleTag 1
      expect(ans).to be nil
    end

    it 'pretest: pressDefault, nothing' do
      p jw.pressVal.initResutString
      expect(jw.pressVal.resultString).to eq ""
    end

    it 'assemble' do
      jw.name = 'test'
      expect(jw.tgStr).to eq "<test>\n</test>"
    end

    it 'assemble, bad Arg' do
      expect{
        jw.setName = 1
      }.to raise_error(NoMethodError)
      
    end

    it 'set cls ' do
      jw.name='p'
      jw.attr(:cls, 'test')
      expect(jw.tgStr).to eq "<p class=\"test\">\n</p>"
    end

    it 'set cls, bad arg' do
      expect{
        jw.setCls = 1
      }.to raise_error(NoMethodError)
    end

    it 'get id and cls' do
      jw.name = 'test'
      jw.attr(:cls, 'sample').attr(:id,'dada')
      expect(jw.tgStr).to eq "<test class=\"sample\" id=\"dada\">\n</test>"
    end

    it 'get id and cls case 2' do
      jw.name = 'test'
      jw.attrSymbol :cls__sample
      jw.attrSymbol :id__data
      expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\">\n</test>"
    end
    
    it 'get id and cls case 3-1'do
      jw.name  = 'test'
      jw.attrSymbol :cls__sample
      expect(jw.tgStr).to eq  "<test class=\"sample\">\n</test>"
    end

    it 'get id and cls case 3-2'do

      jw.name = 'test'
      jw.attr(:cls__sample, :id__data)
      expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\">\n</test>"
    end
    

    it 'get id and cls case 4'do
      jw.name = 'test'
      jw.attr(:cls__sample, :id__data, :name, 'test')
      expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\" name=\"test\">\n</test>"
    end

    it 'get id and cls error case' do
      jw.name = 'test'
      jw.attr(:cls__sample, :id__data, :name) #ignore :name
      expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\">\n</test>"
    end

    it 'get id and cls error case 2'do
      jw.name = 'test'
      jw.attr(:cls__sample, :id__data, 'name') #ignore 'name'
      expect(jw.tgStr).to eq "<test class=\"sample\" id=\"data\">\n</test>"
    end

    it 'add lang ' do
      jw.name = 'p'
      jw.attr(:lang__en)
      expect(jw.tgStr).to eq "<p lang=\"en\">\n</p>"
    end

    it 'add it' do
      jw.name = 'p'
      jw.attr :id__sample
      expect(jw.tgStr).to eq "<p id=\"sample\">\n</p>"
    end

    it 'attr bind with' do
      j = JW.new.attr :id__sample
      expect(j.tgStr).to eq "<jw id=\"sample\">\n</jw>"
    end
    
    it 'attr: replace _to -' do
      j = JW.new.attr(:font_size, '10')
      expect(j.tgStr).to eq "<jw font-size=\"10\">\n</jw>"
    end

    it 'attr bind with __ case 2' do
      j = JW.new.attr(:font_size__10)
      expect(j.tgStr).to eq "<jw font-size=\"10\">\n</jw>"
       
    end

    it 'set cls use symbol'do
      jw.name = 'p'
      jw.attr :cls__test
      expect(jw.tgStr).to eq  "<p class=\"test\">\n</p>"
    end

    it 'set cls no use symbol 'do
      jw.name = 'p'
      jw.attr :cls
      expect(jw.tgStr).to eq  "<p>\n</p>"
    end

    it 'attrWithSymbolsArray'do
      jw.name = 'p'
      arr = [:id__test, :cls__sample]
      jw.attrWithSymbolsArray arr
      expect(jw.tgStr).to eq "<p id=\"test\" class=\"sample\">\n</p>"
    end
    
  end
  
end   
