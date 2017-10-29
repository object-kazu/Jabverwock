require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:inp) { INPUT.new }
    

    it "templeteString is nothing" do
      pr = Press.new
      pr.initResutString
      expect(pr.resultString).to eq ""
      
    end
    
    it "templeteString check" do
      pr = Press.new
      pr.templeteString = "this is test"
      pr.initResutString
      expect(pr.resultString).to eq "this is test"
      
    end
    
    it "insert data " do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable
      pr.initResutString
      pr.insertLabelData("a".varIs(").to eqagain"))
      p pr.resultString
      expect(pr.resultString).to eq "this is test" + $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ").to eqagain" 
    end

    it "error raise" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable
      pr.initResutString
      expect{
        pr.insertData("a")        
      }.to raise_error RuntimeError
    end

    it "use correct class at insertData method" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable
      pr.initResutString
      i = "a".varIs ",again"
      pr.insertData(i)
      expect(pr.resultString).to eq "this is test" + $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again"
    end
    
    it "use correct class at insertDataArray" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable + "b".variable
      pr.initResutString
      i = "a".varIs ",again"
      i2 ="b".varIs ",again"
      pr.insertDataList(i,i2)
      
      ans1 = $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again"
      ans2 = $LABEL_INSERT_START + "b" + $LABEL_INSERT_END + ",again"
      
      expect(pr.resultString).to eq "this is test" + ans1 + ans2
    end

    it "use incorrect class at insertDataArray" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable + "b".variable
      pr.initResutString
      i = "a".varIs ",again"
      i2 ="b".varIs ",again"
      expect{pr.insertDataList(i,i2,"dd")}.to raise_error RuntimeError      
    end

    it "remove all lable" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable + "b".variable
      pr.initResutString
      i = "a".varIs ",again"
      i2 ="b".varIs ",again"
      pr.insertDataList(i,i2)
      pr.removeAllLabel
      expect(pr.resultString).to eq "this is test" + ",again" + ",again"
      
    end


    it "remove all lable when no label string" do
      pr = Press.new
      pr.templeteString = "this is test"
      pr.initResutString
      pr.removeAllLabel # no lable string treat with method removeAllLabel
      expect(pr.resultString).to eq "this is test"
      
    end

    
    it "export result" do
      pr = Press.new
      pr.templeteString = "this is test" + "a".variable + "b".variable
      pr.initResutString
      i = "a".varIs ",again"
      i2 ="b".varIs ",again"
      pr.insertDataList(i,i2)
      pr.removeAllLabel
      pr.core
    end

    it "isExistHeadTag case false" do
      
      pr = Press.new
      pr.templeteString = "<p>this is test</p>"
      pr.initResutString
      expect(pr.isExistHeadTag).to eq false
      
    end

    it "isExistHeadTag case false 2" do
      
      pr = Press.new
      pr.templeteString = "<head>this is test</p>"
      pr.initResutString
      expect(pr.isExistHeadTag).to eq false
      
    end

    it "isExistHeadTag case false 3" do
      
      pr = Press.new
      pr.templeteString = "<p>this is test</head>"
      pr.initResutString
      expect(pr.isExistHeadTag).to eq false

      
    end

    it "isExistHeadTag case true" do
      
      pr = Press.new
      pr.templeteString = "<head>this is test</head>"
      pr.initResutString
      expect(pr.isExistHeadTag).to eq true
      
    end
    
    it "isExistHeadTag case true case 2" do
      
      pr = Press.new
      pr.templeteString = "<head id=\"test\">this is test</head>"
      pr.initResutString
      expect(pr.isExistHeadTag).to eq true
      
    end
    
  end  
end
