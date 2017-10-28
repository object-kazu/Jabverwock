require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:inp) { INPUT.new }
    
    it "single List" do
      expect(inp.name).to eq "input"
    end

    # test "JWOneTag first test" do
    #   ans = @t.pressDefault
    #   assert_equal(ans, "<jwonetag>")

    # end
        
    # test "content add" do
    #   @t.name="j"
    #   @t.content = "test"
    #   ans = @t.pressDefault
    #   ans2 = @t.pressVal.showTempleteString
      
    #   assert_equal(ans, "<j>test")
    #   assert_equal(ans, ans2)
    # end

    # test "add contentIs" do
    #   a = INPUT.new.contentIs "this is test"
    #   assert_equal(a.pressDefault, "<input>this is test")
    # end

   
    
  end  
    

end
