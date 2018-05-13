require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension
using SymbolExtension

module Jabverwock

  RSpec.describe 'doctype test' do
    subject(:doc){DOCTYPE.new}
    
    it 'first test for DOCTYPE' do
      expect(doc.tgStr).to eq "<!DOCTYPE html>"
    end

    it 'modify doctype tag'do
      doc.type = "PUBLIC"
      expect(doc.tgStr).to eq "<!DOCTYPE PUBLIC>"
    end
        
    it "escape double quote" do
      a = "HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\""
      doc.type = a
      expect(doc.tgStr).to eq "<!DOCTYPE #{a}>"
    end    
    
  end
end
