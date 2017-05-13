require 'test/unit'
require '../../lib/global/globalDef'  

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class GlobaDefTest < Test::Unit::TestCase
    class << self
      # テスト群の実行前に呼ばれる．変な初期化トリックがいらなくなる
      def startup
        p :_startup
      end

      # テスト群の実行後に呼ばれる
      def shutdown
        p :_shutdown
      end
    end

    # 毎回テスト実行前に呼ばれる
    def setup
      p :setup
    end

    # テストがpassedになっている場合に，テスト実行後に呼ばれる．テスト後の状態確認とかに使える
    def cleanup
      p :cleanup
    end

    # 毎回テスト実行後に呼ばれる
    def teardown
      p :treadown
    end

    ############## test ###############
    test "global?" do
      p $SPC + "good"
    end

    ############## CssUtil ###############

    test "hasSymbolArrTargetSymbol case true" do
      a = %i(a b c)
      assert_true CssUtil.hasSymbolArrTargetSymbol :a, a
    end
    
    test "hasSymbolArrTargetSymbol case false" do
      a = %i(a b c)
      assert_false CssUtil.hasSymbolArrTargetSymbol :ab, a
    end

    
    
    ############## KSting ###############

    #check_type
    test"check type case pass"do
      tm = "a"
      tm = KString.check_type(String,tm)
      assert_equal(tm,true)
    end
       
    test "check type straing" do
      tm = "a"
      tm = KString.isString?(tm)
      assert_equal(tm ,true)
    end

    #variable
    test "variable insert" do
      tm = "a".variable
      ans = $LABEL_INSERT_START + "a" + $LABEL_INSERT_END
      assert_equal(tm, ans)
    end


    test "removeLastRET" do
      tm = "dadfafadfa\nfdfafadfa\n"
      tm = KString.removeLastRET(tm)
      assert_equal(tm, "dadfafadfa\nfdfafadfa")

    end

    test "removeLastRET not RET" do
      tm = "dadfafadfa\nfdfafadfa_"
      tm = KString.removeLastRET(tm)
      assert_equal(tm, "dadfafadfa\nfdfafadfa_")

    end
    
    test "removeLastRET String extension" do
      tm = "dadfafadfa\nfdfafadfa\n"
      tm = tm.removeLastRET
      assert_equal(tm, "dadfafadfa\nfdfafadfa")
    end

    test "removeLastRET String extension with out LastRET" do
      tm = "dadfafadfa\nfdfafadfaA"
      tm = tm.removeLastRET
      assert_equal(tm, "dadfafadfa\nfdfafadfaA")
    end


    test "addSpace" do
      tm = "a"
      tm = KString.addSpace(tm)
      assert_equal(tm," a")
    end

    test "addSpace, erro raise" do
      tm = 1
      assert_raise(){
        tm = KString.addSpace(tm)        
      }

    end
    
    test "stringArrayConectRET" do
      arr = ["aaa", "bbb", "ccc"]
      res = KString.stringArrayConectRET(arr)
      assert_equal(res, "aaa\nbbb\nccc\n")
    end

    test "stringArrayConectRET, raise error" do
      arr = ["aaa", 1, "ccc"]
      assert_raise(){
        res = KString.stringArrayConectRET(arr)        
      }
    end

    test "reprace str of with" do
      target = "this is test"
      target = KString.reprace(str: target, of:"this", with: "that")
      assert_equal(target, "that is test")
    end
    
    test "reprace str of with case 2" do
      target = "this is test"
      assert_equal( KString.reprace(str: target, of:"this", with: "that"), "that is test")
    end

    
    test "reprace str of with , incorrct argu" do
      target = "this is test"
      assert_raise(){
        target = KString.reprace(str: target, of:"this", with: 1)
      }
    end


    
    test "a variable and data pair is true " do
      a = "a".varIs("aa")
      assert_true(a.is_a?(Hash))
    end


    test "a variable and data pair is false" do
      a = "a"
      assert_false(a.is_a?(Hash))
      
    end

    test "confirm variable pair " do
      a = "a".varIs("aa")
      assert_equal(a[:label], "a")
      assert_equal(a[:data], "aa")
    end


    test "isExistCssString case" do
      ### true ### no style
      a = "p {\n\n}"
      ans = KString.isExistCssString a
      assert_false ans
      
      a = "p"
      ans = KString.isExistCssString a
      assert_false ans
      
      a = "jw_css {\n" + "\n" + "}"
      ans = KString.isExistCssString a
      assert_false ans
      
      ### false ### with style
      a = "p {aaa}"
      ans = KString.isExistCssString a
      assert_true ans
      
      a = "p {aa}"
      ans = KString.isExistCssString a
      assert_true ans
      
      a = "p {\n\tfont-size: 10;\n}"
      ans = KString.isExistCssString a
      assert_true ans
      
    end

    test "reader" do
      a = "a\nb"
      ans = KString.reader a
      assert_equal ans, ["a\n","b"]
       
    end


    test "insertIndex" do
      a = ["a", "b", "<\/body>"]
      ans = KString.insertIndex a
      assert_equal ans, 2
      
    end

    test "insert Target befor </body>" do
      a = ["a", "b", "<\/body>"]
      index = KString.insertIndex a
      a.insert index,"!!"
      assert_equal a,  ["a", "b","!!", "<\/body>"]
      
    end

    test "insertTextLoop" do
      a = %w(a b </body>)
      ans = KString.insertTextLoop a
      assert_equal ans, "a\nb\n</body>\n"
      
    end
    
    test "insertText befor </body>" do
      a = ["a", "b", "<\/body>"]
      ans = KString.insertText a, "!!"
      assert_equal ans, "a\nb\n!!\n<\/body>\n"
    end


    test "removeAllRET" do
      a = ["a\n", "b\n", "c"]
      b = KString.removeAllRET a
      assert_equal b, ["a", "b", "c"]
    end

    test "isExistCssString case 1" do
      test = "head {\nfont-size: 10;\n}"
    end
    
    test "isExistCssString case 2" do

      test = "head#sample {\ncolor: red;\n}"
    end

    
    test "addTabEachArray" do
      l = ["a", "b"]
      ans = KString.addTabEachArray l, 3
      assert_equal ans, "a\t\t\tb"
    end


    
    
  end
end
