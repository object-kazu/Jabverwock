require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jwComment basic test' do
    subject(:jwc) { COMMENT.new }    
    it 'is name' do
      expect(jwc.name).to eq 'comment' 
    end

    it 'is test for tagManager func isComment'do
      expect(jwc.tagManager.name).to eq "comment"
    end

    it 'add comment ' do
      jwc.contentIs "test"
      expect(jwc.tgStr).to eq "<!-- test -->"
    end

    it 'comment add members' do
      pp = P.new.contentIs"this"
      p2 = P.new.contentIs"that"
      p3 = jwc.contentIs"test"
           
      pp.addMembers(p3,p2)
      
      expect(pp.tgStr).to eq "<p>this</p>\n<!-- test -->\n<p>that</p>\n"
     
    end
    
  end

  
end   
