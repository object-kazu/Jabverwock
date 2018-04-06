require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jj class initial test' do
    
    # it 'JJ class define method' do
    #   div1 = JJ.DIV
    #   expect(div1.tgStr).to eq "<div>\n</div>"
    # end

    # it 'JJ class define method 2' do
    #   div1 = JJ.p.contentIs "test"
    #   expect(div1.tgStr).to eq "<p>test</p>"
    # end

    # it 'check allTags' do
    #   div1 = JJ.p.contentIs "test"
    #   expect(div1.tgStr).to eq "<p>test</p>"
    # end
    
    it 'check allTags, oneTags' do
      doc = JJ.doctype
      expect(doc.tgStr).to eq "<!DOCTYPE html>"
    end

  end
  
end   

