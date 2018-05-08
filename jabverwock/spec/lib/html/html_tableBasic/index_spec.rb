require 'spec_helper'
require_relative '../../../lib/paths'


  using StringExtension
  using ArrayExtension
  using SymbolExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    def self.iTable
      t = JWTable.new.attr(:border, "1px")
      
      a1 = ["row1 cell1", "row1 cell2" ]
      a2 = ["row2 cell1", "row2 cell2" ]
      a3 = ["row3 cell1", "row3 cell2" ]
      
      t.addRows a1, a2, a3
      t
    end
    
    def self.bodies
      body = BODY.new
      c = HEADING.new.contentIs "Hello table"
      body.addChildren c, iTable
      body
    end

    html= HTML.new
    html.addChild bodies
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
