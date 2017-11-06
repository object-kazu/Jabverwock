require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    it "document.getElementById case 1" do
      img = IMG.new.attr(:id__MyImage, :src, "simple.gif")      
      img.js.doc.byID.src("landscape.jpg".dQuo)
      
      ans = "document.getElementById('MyImage').src = \"landscape.jpg\";"
      expect(ans).to eq img.js.orders[0]
      
    end
    
    it "document.getElementById case 2" do
      img = IMG.new.attr(:id,"MyImage").attr(:src, "simple.gif")
      img.js.doc.byID.src("landscape.jpg".dQuo)
      
      ans = "document.getElementById('MyImage').src = \"landscape.jpg\";"
      expect(ans).to eq img.js.orders[0]
      
    end
    
    it "document.getElementById case 3" do
      img = IMG.new.attr(:id__MyImage).attr(:src, "simple.gif")
      
      img.js.doc.byID.src("landscape.jpg".dQuo)
      
      ans = "document.getElementById('MyImage').src = \"landscape.jpg\";"
      expect(ans).to eq img.js.orders[0]
      
    end
    
    # # ##### ByClass ###########
    it "document.getElementByClass case 1" do
      img = IMG.new.attr(:cls__MyImage, :src, "simple.gif")      
      img.js.doc.byClassName.src("landscape.jpg".dQuo)
      
      ans = "document.getElementByClassName('MyImage').src = \"landscape.jpg\";"
      expect(ans).to eq img.js.orders[0]
      
    end
    
    it "document.getElementByCls case 2" do
      img = IMG.new.attr(:cls,"sample").attr(:src, "simple.gif")
      img.js.doc.byClassName.src("landscape.jpg".dQuo)
      
      ans = "document.getElementByClassName('sample').src = \"landscape.jpg\";"
      expect(ans).to eq img.js.orders[0]
      
    end
    
    
    
  end
end
