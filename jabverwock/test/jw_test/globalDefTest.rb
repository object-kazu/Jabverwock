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


    
    ############## String Extension ###############
    
    test "string extension inSingleQuo" do
      tm =  "a".inSingleQuo("bc")
      assert_equal(tm, "a'bc'")

    end

    test "string extension inSingleQuo fail" do
      tm =  "a".inSingleQuo(1)
      assert_equal(tm, nil)

    end

    test "string extension inDoubleQuot" do
      tm =  "a".inDoubleQuot("bc")
      assert_equal(tm, "a\"bc\"")

    end

    test "string extension inDoubleQuot fail" do
      tm =  "a".inDoubleQuot(1)
      assert_equal(tm, nil)

    end

    test"string extension inPara" do
      tm = "a".inParenth("bc")
      assert_equal(tm,"a('bc')")
    end
    
    test"string extension inPara fail" do
      tm = "a".inParenth(1)
      assert_equal(tm,nil)
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

    
    test "removeLastTAB" do
      tm = "dadfafadfa\tfdfafadfa\t"
      tm = KString.removeLastTAB(tm)
      assert_equal(tm, "dadfafadfa\tfdfafadfa")

    end

    
    test "removeLastTAB case 2" do
      tm = "dadfafadfa\tfdfafadfa"
      tm = KString.removeLastTAB(tm)
      assert_equal(tm, "dadfafadfa\tfdfafadfa")

    end

    
    test "removeHeadTAB" do
      tm = "\tdadfafadfa\tfdfafadfa\t"
      tm = KString.removeHeadTAB(tm)
      assert_equal(tm, "dadfafadfa\tfdfafadfa\t")

    end
    
    test "removeHeadTAB without head tab" do
      tm = "dadfafadfa\tfdfafadfa\t"
      tm = KString.removeHeadTAB(tm)
      assert_equal(tm, "dadfafadfa\tfdfafadfa\t")

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

    test "count tab number" do
      target = "abc" + $TAB + "decg" + $TAB + "dfdfdfa"
      ans = KString.tabCount(target)
      assert_equal(ans,2)
    end

    test "count tab number and end tab" do
      target = "abc" + $TAB + "decg" + $TAB
      ans = KString.tabCount(target)
      assert_equal(ans,1) # because end Tab remove at tabCount method
      
    end
    
    test "getTabNumber" do
      target = $TAB + "abc" + $TAB + "decg" + $TAB
      ans = KString.getTabNumber(target)
      assert_equal(ans,2)
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
      a = ["a", "b", "<\/head>"]
      ans = KString.insertIndex a
      assert_equal ans, 2
      
    end

    test "insert Target befor </head>" do
      a = ["a", "b", "<\/head>"]
      index = KString.insertIndex a
      a.insert index,"!!"
      assert_equal a,  ["a", "b","!!", "<\/head>"]
      
    end
    
    test "insertText befor </head>" do
      a = ["a", "b", "<\/head>"]
      ans = KString.insertText a, "!!"
      assert_equal ans, "\ta\n\tb\n\t!!\n\t<\/head>\n"
    end
    
    
    
    # ## Array extension ############
    test "append val" do
      a = [2,3,4]
      a.append 5
      assert_equal(a, [2,3,4,5])
    end
    
    test "append val case 2" do
      a = [2,3,4]
      a.append [5]
      assert_equal(a, [2,3,4,5])
    end

    test "appends vals" do
      a = [2,3,4]
      a.appends [5,6]
      assert_equal(a, [2,3,4,5,6])
    end
    
    test "appends vals case 2" do
      a = [2,3,4]
      a.appends [11,22], [33,33]
      assert_equal(a, [2,3,4,11,22,33,33])
    end
    
    
    # ## Symbol extension ############
    test "isDoubleUnderBarSymbole, false" do
      a = :test
      assert_false a.hasDoubleUnderBar?
      
    end
    
    test "isDoubleUnderBarSymbole, true" do
      a = :test__test
      assert_true a.hasDoubleUnderBar?
      
    end
    
    
    
  end

end


    # test "addTab" do
    #   target = "a"
    #   ans  = KString.addTab(str: target, num: 2)
    #   assert_equal(ans, $TAB + $TAB + target)
    # end
    # test "callSelfCls" do
    #   tm = "d"
    #    assert_equal("String", KSUtil.callSelfCls(tm))
    # end
    # test "is_Bool" do
    #   assert_true(KSUtil.is_bool(true))
    #   assert_false(KSUtil.is_bool(1))
    # end
