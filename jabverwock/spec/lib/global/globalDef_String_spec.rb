require 'spec_helper'
require_relative '../../lib/paths'

using ArrayExtension
using StringExtension
using SymbolExtension

module Jabverwock
  # RSpec.describe 'CssUtil' do
  #   it 'hasSymbolArrTargetSymbol case true' do
  #     a = %i(a b c)
  #     expect(CssUtil.hasSymbolArrTargetSymbol(:a, a)).to eq true
  #   end

  #   it 'hasSymbolArrTargetSymbol case false' do
  #     a = %i(a b c)
  #     expect(CssUtil.hasSymbolArrTargetSymbol(:ab, a)).to eq false
  #   end
    
  # end
  
  RSpec.describe 'String extension' do
    it 'first key' do
      expect(KSHash::FIRST_KEY).to eq :js1  
    end

    it 'check type case pass' do
      tm = 'a'
      tm = KString.check_type String, tm
      expect(tm).to eq true
    end

    it 'check type straing' do
      tm = 'a'
      tm = KString.isString? tm
      expect(tm).to eq true
    end
    
    #variable
    it 'insert' do
      tm = 'a'.variable
      ans = $LABEL_INSERT_START + 'a' + $LABEL_INSERT_END
      expect(tm).to eq ans
    end

    it 'removeLastRET' do
      tm = "dadadadad\nerqqrqerq\n"
      tm = KString.removeLastRET(tm)
      expect(tm).to eq "dadadadad\nerqqrqerq"
                               
    end


    it "removeLastRET" do
      tm = "dadfafadfa\nfdfafadfa\n"
      tm = KString.removeLastRET(tm)
      expect(tm).to eq "dadfafadfa\nfdfafadfa"

    end

    it "removeLastRET not RET" do
      tm = "dadfafadfa\nfdfafadfa_"
      tm = KString.removeLastRET(tm)
      expect(tm).to eq "dadfafadfa\nfdfafadfa_"

    end
    
    it "removeLastRET String extension" do
      tm = "dadfafadfa\nfdfafadfa\n"
      tm = tm.removeLastRET
      expect(tm).to eq "dadfafadfa\nfdfafadfa"
    end

    it "removeLastRET String extension with out LastRET" do
      tm = "dadfafadfa\nfdfafadfaA"
      tm = tm.removeLastRET
      expect(tm).to eq "dadfafadfa\nfdfafadfaA"
    end


    it "addSpace" do
      tm = "a"
      tm = KString.addSpace(tm)
      expect(tm).to eq " a"
    end

    it "addSpace).to eq erro raise" do
      tm = 1
      expect {tm = KString.addSpace(tm) }.to raise_error(StandardError)

    end
    
    it "stringArrayConectRET" do
      arr = ["aaa", "bbb", "ccc"]
      res = KString.stringArrayConectRET(arr)
      expect(res).to eq  "aaa\nbbb\nccc\n"
    end

    it "stringArrayConectRET, raise error" do
      arr = ["aaa", 1, "ccc"]
      expect {KString.stringArrayConectRET(arr)}.to raise_error(StandardError)
    end

    it "reprace str of with" do
      target = "this is test"
      target = KString.reprace(str: target, of:"this", with: "that")
      expect(target).to eq "that is test"
    end
    
    it "reprace str of with case 2" do
      target = "this is test"
      expect( KString.reprace(str: target, of:"this", with: "that")).to eq "that is test"
    end

    
    it "reprace str of with , incorrct argu" do
      target = "this is test"
      expect {
        target = KString.reprace(str: target, of:"this", with: 1)
      }.to raise_error(StandardError)
    end


    
    it "a variable and data pair is true " do
      a = "a".varIs("aa")
      expect(a.is_a?(Hash)).to eq true
    end


    it "a variable and data pair is false" do
      a = "a"
      expect(a.is_a?(Hash)).to eq false
      
    end

    it "confirm variable pair " do
      a = "a".varIs("aa")
      expect(a[:label]).to eq "a"
      expect(a[:data]).to eq "aa"
    end


    it "isExistCssString case" do
      ### true ### no style
      a = "p {\n\n}"
      ans = KString.isExistCssString a
      expect( ans).to eq false
      
      a = "p"
      ans = KString.isExistCssString a
      expect( ans).to eq false
      
      a = "jw_css {\n" + "\n" + "}"
      ans = KString.isExistCssString a
      expect( ans).to eq false
      
      ### false ### with style
      a = "p {aaa}"
      ans = KString.isExistCssString a
      expect( ans).to eq true
      
      a = "p {aa}"
      ans = KString.isExistCssString a
      expect( ans).to eq true

      
      a = "p {\n\tfont-size: 10;\n}"
      ans = KString.isExistCssString a
      expect( ans).to eq true
      
    end

    it "reader" do
      a = "a\nb"
      ans = KString.reader a
      expect(ans).to eq ["a\n","b"]
       
    end
    
    it "insertText befor </body>" do
      a = ["a", "b", "<\/body>"]
      ans = KString.insertText a, "!!"
      expect(ans).to eq "a\nb\n!!\n<\/body>\n"
    end


    it "removeAllRET" do
      a = ["a\n", "b\n", "c"]
      b = KString.removeAllRET a
      expect(b).to eq ["a", "b", "c"]
    end

    
    it "addTabEachArray" do
      l = ["a", "b"]
      ans = KString.addTabEachArray l, 3
      expect(ans).to eq "a\t\t\tb"
    end

    
    
  end
end

   

