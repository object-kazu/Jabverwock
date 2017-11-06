require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    subject(:meta){META.new}
    
    it "confirm name" do
      expect(meta.name ).to eq "meta"
    end

    it "press" do
      expect(meta.press).to eq "<meta>"
    end

    it "add charset" do
      meta.attr(:charset, "en")
      expect(meta.press).to eq "<meta charset=\"en\">"
    end
    

  end
end
