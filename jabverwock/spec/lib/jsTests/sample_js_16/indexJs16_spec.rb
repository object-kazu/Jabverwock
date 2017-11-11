
require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension
using SymbolExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    class << self
      def bodier
        body = BODY.new
        
        p1 = P.new.contentIs "Hello World!"
        p2 = P.new.contentIs "Hello Norway!"
        p3 = P.new.attr(:id__demo)
        
        p1.jdoc.byTagName.is_var :myCollection
        v = p3.js.var.collection(:myCollection, 0, 'innerHTML').cut
        b = "The innerHTML of the second paragraph is:".dQuo.plus "#{v}"
        p3.jdoc.byID.innerHTML b

        body.addChildren p1, p2, p3
        body
      end
    end
    
    html = HTML.new
    html.addChild bodier
    
    doc = DOCTYPE.new
    doc.addMember html
    doc.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)
    
  end
end
