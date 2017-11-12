require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    it "head and script" do
      h = HEAD.new

      parent = JW_CSS_JS.new.attr(:id__sample)
      parent.js.doc.write("parent")
      
      child  = JW_CSS_JS.new.attr(:id__test)
      child.js.doc.write("child")
      child.js.doc.write("child again")
      
      h.addMember parent
      h.addMember child
      
      p h.tgStr
    end
 end
end
