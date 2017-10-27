require 'spec_helper'
require_relative '../../lib/paths'

using ArrayExtension
using SymbolExtension

module Jabverwock
  
  RSpec.describe 'hash extension' do
    
    # # ## Symbol extension ############
    it "isDoubleUnderBarSymbole, false" do
      a = :test
      expect(a.hasDoubleUnderBar?).to eq false
    end
    
    it "isDoubleUnderBarSymbole, true" do
      a = :test__test
      expect(a.hasDoubleUnderBar?).to eq true
    end
    
  end
end

