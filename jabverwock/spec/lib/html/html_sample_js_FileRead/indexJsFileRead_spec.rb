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
        pp = P.new.attr(:id__div1)
        pp.jsRead "spec/lib/css/html_sample_js_FileRead/sample.js"

        body.addChild pp
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
