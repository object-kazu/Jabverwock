require 'spec_helper'
require_relative '../../lib/paths'


using ArrayExtension
using StringExtension

RSpec.describe 'string Extensions' do

    it "string extension inSingleQuo" do
      tm =  "a".inSingleQuo("bc")
      expect(tm).to eq "a'bc'"

    end

    it "string extension inSingleQuo fail" do
      tm =  "a".inSingleQuo(1)
      expect(tm).to eq nil

    end

    it "string extension inDoubleQuot" do
      tm =  "a".inDoubleQuot("bc")
      expect(tm).to eq "a\"bc\""

    end

    it "string extension inDoubleQuot fail" do
      tm =  "a".inDoubleQuot(1)
      expect(tm).to eq nil

    end

    it"string extension inPara" do
      tm = "a".inParenth("bc")
      expect(tm).to eq"a('bc')"
    end
    
    it"string extension inPara fail" do
      tm = "a".inParenth(1)
      expect(tm).to eq nil
    end

  
end
