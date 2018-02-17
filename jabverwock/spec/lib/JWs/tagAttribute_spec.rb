require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:inp) { INPUT.new }
    
    it "TagAttribute, path confirm " do
      tm = TagAttribute.new 
      tm.add_lang("jp")

      expect(tm.aString).to eq "lang=\"jp\""
      
    end  

    it "TagAttribute, class " do
      tm = TagAttribute.new 
      tm.add_cls("test" )

      expect(tm.aString).to eq "class=\"test\""
      
    end  
    
    it "TagAttribute, class case 2 " do
      tm = TagAttribute.new 
      tm.add_font_size("test" )

      expect(tm.aString).to eq "font-size=\"test\""
      
    end  

    it "TagAttribute, enctype " do
      tm = TagAttribute.new 
      tm.add_enctype("test" )

      expect(tm.aString).to eq "enctype=\"test\""
      
    end  
   
    
  end  
    

end
