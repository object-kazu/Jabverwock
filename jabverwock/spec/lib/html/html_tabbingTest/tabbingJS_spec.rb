require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'tabbing js ' do
    subject(:tj){TabbingJS.new}
    
    it "mainloop"do
      l1="<script>\n"
      l2="document.write(\"hello world\")\n"
      l3="</script>"
      ll = l1 << l2 << l3
      tj.readLine ll

      p ">>>"
      p tj.tabbedTxt

      p tj.tabbedArr
    end
  end
end
