
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
        
        ### JSFunction ####
        h1 = HEADING.new.attr(:id__id01).contentIs "My First Page"
        hv =  h1.js.doc.byID.firstChild(:value).cut
        h1.js.doc.byID.firstChild(:value).is_var(:myHead)
        
        title = TITLE.new.attr(:id__demo).contentIs "DOM Tutorial"
        title.js.doc.byID.childNodes(0,:value).is_var(:myTitle)
        
        pp = P.new.attr(:id__id02)
        pp.js.doc.byID.innerHTML(hv)
        body.addChildren h1,title,pp
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
