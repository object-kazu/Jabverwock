require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jk class initial test' do
    
    it 'JK class define method' do
      div1 = JK.div
      expect(div1.tgStr).to eq "<div>\n</div>"
    end

    it 'JK class define method 2' do
      div1 = JK.p.contentIs "test"
      expect(div1.tgStr).to eq "<p>test</p>"
    end

    it 'check allTags' do
      div1 = JK.p.contentIs "test"
      expect(div1.tgStr).to eq "<p>test</p>"
    end
    
    it 'check allTags, oneTags' do
      doc = JK.doctype
      expect(doc.tgStr).to eq "<!DOCTYPE html>"
    end

  end
  
end   

