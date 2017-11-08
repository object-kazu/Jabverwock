
require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension
using SymbolExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    class << self
      
      
      def header
        head = HEAD.new
        title = TITLE.new
        title.content = "hello world"
        head.addChild title
        
        head
      end

      
      # def bodier
      #   body = BODY.new
      #   para = P.new.attr(:id__test).contentIs "yes"
      #   para.js.doc.byID.innerHTML("test done".dQuo)

      #   para2 = P.new.contentIs "yes yes"
      #   para2.js.doc.byTagName.innerHTML("test again".dQuo)

      #   para3 = P.new.attr(:cls__sample).contentIs "yes no"
      #   para3.js.doc.byClassName.innerHTML("test forever".dQuo)
      
      #   body.addChild para
      #   body.addChild para3
      #   body.addChild para2
      
      #   body
      # end
      
      ## another way
      def bodier
        body = BODY.new
        para = P.new.attr(:id__test).contentIs "yes"
        para.jdoc.byID.innerHTML("test done".dQuo)

        para2 = P.new.contentIs "yes yes"
        para2.jdoc.byTagName.innerHTML("test again".dQuo)

        para3 = P.new.attr(:cls__sample).contentIs "yes no"
        para3.jdoc.byClassName.innerHTML("test forever".dQuo)
        
        body.addChildren para, para3, para2
        
        body
      end
      
      
    end
    
    
    html = HTML.new
    
    html.addChild header
    html.addChild bodier
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)
    
  end
end
