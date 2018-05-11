require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension

module Jabverwock

  RSpec.describe 'css test' do

    html= HTML.new

    def self.itemList (item)
      arr = []
      unless item.is_a? Array
        l = LI.new.contentIs item
        arr.append l
        return arr
      end
      
      if item.count > 0
        item.each do |i|
          l = LI.new.contentIs i     
          arr.append l 
        end
      end

      arr
    end
    
    def self.mList(title, *items)
      lm = LI.new($MT).contentIs title
      ul = UL.new
      l1 = itemList items
      ul.addChildren l1
      lm.addChild ul
      lm    
    end
    
    def self.orderList()
      o = OL.new
      ml = mList("Food", "a","b","c")
      mm = mList("Toy","1","2","3")
      o.addChildren [ml, mm]
      o
    end
    
    def self.bodier
      body = BODY.new
      body.addChild orderList
      body
    end
    
    html.addChild bodier
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
