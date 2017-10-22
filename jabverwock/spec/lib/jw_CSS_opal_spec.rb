require 'spec_helper'
require_relative '../lib/paths'

using ArrayExtension
using StringExtension
using SymbolExtension

module Jabverwock
  
  RSpec.describe 'path test' do
    subject(:oo) { JW_CSS_OPAL_JS.new }
    
    it 'path is exist' do
      oo.opalPath = "/test"
      expect(oo.isExistOpalScript).to eq true

    end

    it 'path is not exist' do
      oo.opalPath = ""
      expect(oo.isExistOpalScript).to eq false
    end

    it 'file name, incorrect' do
      oo.opalPath = ""
      oo.readOpalFile ("/test") 
      expect(oo.opalFileName).to eq ""
    end

  end


    
end
  

