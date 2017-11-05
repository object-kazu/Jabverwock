require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'jw table test' do
    
    it "add header" do
      t = JWTable.new
      t.caption "test"
      t.headerList ["name","address","tel"]
      ans = t.press
      
      l1= "<table>\n"
      l2="<caption>test</caption>\n"
      l3="<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>\n"
      lend="</table>"

      expect(ans).to eq l1 + l2 + l3 + lend
      
    end
        
  end
end
