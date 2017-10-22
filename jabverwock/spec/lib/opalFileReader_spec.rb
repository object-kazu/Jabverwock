require 'spec_helper'
require_relative '../lib/paths'

using ArrayExtension
using StringExtension
using SymbolExtension

module Jabverwock
  
  RSpec.describe 'path test' do
    subject(:of) { OpalFileReader.new }
    
    it 'isRubyCode, not ruby' do
      file = "test"
      expect(of.isRubyCode(file)).to eq false
    end
    
    it 'isRubyCode, not ruby case code c' do
      file = "test.cc"
      expect(of.isRubyCode(file)).to eq false
    end
    
    it 'isRubyCode, yes ruby' do
      file = "test.rb"
      expect(of.isRubyCode(file)).to eq true
    end

    it 'isRubyCode, yes ruby case path' do
      file = "~/test.rb"
      expect(of.isRubyCode(file)).to eq true
    end

    it 'extractFileName, correct' do
      file = "~/test.rb"
      expect(of.extractFileName(file)).to eq "test"
    end

    it 'extractFileName, incorrect' do
      file = "~/test.cc"
      expect(of.extractFileName(file)).to eq "error, select ruby code"
    end
    
    it 'extractFilePath, correct ' do
      file = "~/test.rb"
      expect(of.extractFilePath(file)).to eq "~"
    end

    it 'extractFilePath, correct ' do
      file = "~/test.rb"
      expect(of.extractFilePath(file)).to eq "~"
    end
    

    
    it 'extractFilePath, incorrect' do
      file = 'test.rb'
      expect(of.extractFilePath(file)).to eq "."
    end


    it 'extractFilePath, long path ' do
      file = "/Users/shimizukazuyuki/ActiveProject/opalTest/hellow.rb"
      expect(of.extractFilePath(file)).to eq "/Users/shimizukazuyuki/ActiveProject/opalTest"
    end
    it 'extractFileName, long path ' do
      file = "/Users/shimizukazuyuki/ActiveProject/opalTest/hellow.rb"
      expect(of.extractFileName(file)).to eq "hellow"
    end


  end
  
  # RSpec.describe 'readIn ' do
  #   subject(:of) { OpalFileReader.new }
    
  #   it 'readIn' do
  #     file = "/Users/shimizukazuyuki/ActiveProject/opalTest/hellow.rb"
  #     expect(of.readIn(file)).to eq ""
  #   end

  # end    
  
end
