require 'spec_helper'
require_relative '../../lib/paths'

using ArrayExtension
using StringExtension
using SymbolExtension

module Jabverwock
  
  RSpec.describe JW_CSS_OPAL_JS do
    subject(:oo){ JW_CSS_OPAL_JS.new }
    
    it 'press js_CSS_opal_js' do
      oo.pressTo(name: 'opal_test_indexPressed2.html', dist: KSUtil.myPATH)
    end

    
    it 'path is exist' do
      oo.opalPath = "/test"
      expect(oo.isExistOpalScript).to eq true

    end

    it 'path is not exist' do
      oo.opalPath = ""
      expect(oo.isExistOpalScript).to eq false
    end

    it 'file name, incorrect' do
      oo.opalPath = ""
      oo.readOpalFile ("/test") 
      expect(oo.opalFileName).to eq ""
    end
    
    it 'read opal file' do
      testPath = "/Users/shimizukazuyuki/ActiveProject/opalTest/hellow.rb"   
      oo.readOpalFile testPath
      oo.pressTo(name: 'read_OPal_file_indexPressed2.html', dist: KSUtil.myPATH)
    end

  end

  RSpec.describe 'opal press' do
    subject(:op) {
      class << self
        
        def header
          head = HEAD.new
          title = TITLE.new.contentIs "hello world"
          head.addChild title

        end
        
        def bodier
          body = BODY.new
          pp = P.new.attr(:id__div1)

          body.addChild pp
          body
        end
      end

      html = HTML.new
      html.addChild header
      html.addChild bodier
  
      doc = DOCTYPE.new
      doc.addMember html
      
      doc.readOpalFile "/Users/shimizukazuyuki/ActiveProject/opalTest/hellow.rb"
      doc.pressTo(name: 'opal_test_indexPressed.html', dist: KSUtil.myPATH)

    }



    
    
  end
end
