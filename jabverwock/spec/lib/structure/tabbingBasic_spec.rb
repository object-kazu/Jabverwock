require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'tabbing basic test' do
    subject(:tb) { Tabbing.new }    
    it 'is test for path test' do
      expect(tb.footPrint).to eq "tabbing read"
      
    end
             
  end

  RSpec.describe 'insert variable' do

        
  end
  
end   

