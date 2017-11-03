require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'jsFunction test' do
    subject(:jsf){JsFunction.new}
    
    ### function ###
    
    it "function no arg" do
      
      jsf.define "test", "code is dead;"
      expect(jsf.orders[0]).to eq "function test(){
      code is dead;
      }"
      
    end

    it "function with arg" do
      
      jsf.define "test", "name" ,"age", "code is dead;"
      expect(jsf.orders[0]).to eq  "function test(name, age){
      code is dead;
      }"
      
    end
    
    it "function with arg as symbol" do
      
      jsf.define :test, :name , :age,"code is dead;"
      expect(jsf.orders[0]).to eq  "function test(name, age){
      code is dead;
      }"
      
    end

    
    

  end
end
