
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
        div = DIV.new.attr(:id__div1)
        
        ### JSFunction ####
        p1 = P.new.attr(:id__p1).contentIs "This is a paragraph."
        p2 = P.new.attr(:id__p2).contentIs "This is another paragraph."

        div.addChildren p1, p2

        div.jdoc.selfy{ |t|
          t.createElement(:p).is_var :para
          t.createTextNode('This is new.'.sQuo).is_var :node
          t.appendChild(:para, :node)
          t.byID.is_var :element
          t.appendChild(:element, :para)
        }
        
        # div.js.doc.createElement(:p).is_var :para
        # div.js.doc.createTextNode('This is new.'.sQuo).is_var :node
        # div.js.doc.appendChild(:para, :node)
        
        # div.jdoc.byID.is_var :element
        # div.js.doc.appendChild(:element, :para)
        
        body.addChild div
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
