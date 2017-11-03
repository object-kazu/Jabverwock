require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'FileReader test' do
    subject(:jsf){JsFileReader.new}
    
    it "file read" do
      @jsf.read "sample.js"
      p @jsf.jsArr
    end

    it "file read in path" do
      p @jsf.readIn "./sample.js"
      
    end
    

  end
end
