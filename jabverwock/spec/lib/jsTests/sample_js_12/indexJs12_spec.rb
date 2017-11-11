
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
        
        p1 = P.new.attr(:id__p1).contentIs "This is a paragraph."
        p2 = P.new.attr(:id__p2).contentIs "This is another paragraph."


        #create new node
        div.jdoc.createElement(:p).is_var :para
        div.jdoc.createTextNode('This is new.'.sQuo).is_var :node
        div.jdoc.appendChild(:para, :node)
        div.jdoc.byID.is_var :element
        div.jdoc.insertBefore "element", "para"
        div.jdoc.byID.is_var :title3Node
        
        div.jdoc.selfy { |t|
          t.createElement(:div).is_var :newNode
          t.createTextNode('CSS'.sQuo).is_var :textNode
          t.appendChild(:newNode, :textNode)
          t.equal "newNode.id", "title2".sQuo
          t.insertBefore "title3Node", "newNode"
        }

        div.addChildren p1, p2
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
