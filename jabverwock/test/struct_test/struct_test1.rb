require "./path"
require 'test/unit'


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  class PrepTest < Test::Unit::TestCase
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

      @st = Structure.new
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

    # test "path " do
    #   p @st
    # end
    
    test "prep case space 1" do
      a = "doc, head"
      b = "doc,  head"
      assert_equal(@st.prep(a), "doc,head")

    end

    test "prep case tab" do
      b = "doc,  \thead"
      assert_equal(@st.prep(b), "doc,head")

    end

    test "prep case retuen " do
      t = "doc,\nhead"
      assert_equal(@st.prep(t), "doc,head")

    end

    
    test "arraying case 1" do
      t = "a,b{c}"
      arr = @st.arraying t
      ans = ["a", $MEMBER, "b", $CHILD, "c", $ENDMARK]
      assert_equal(arr, ans)
           
    end
    
    test "arraying case 2" do
      t = "doc,head{h1}"
      arr = @st.arraying t
      ans = ["doc", $MEMBER, "head", $CHILD, "h1", $ENDMARK]
      assert_equal(arr, ans)
           
    end
    test "arraying case 3" do
      # a{b,c{d},e},f
      # "{" => "_c_", "}" => "_e_", "," => "_m_"
      # => ["a", "_c_", "b", "_m_", "c","_c_","d", "_e_","_m_", "e","_e_", "_m_", "f"]
      t = "a{b,c{d},e},f"
      arr = @st.arraying t
      ans = ["a", "_c_", "b", "_m_", "c","_c_","d", "_e_","_m_", "e","_e_", "_m_", "f"]

      assert_equal arr, ans
      
    end
    
    test "recordPar" do
      @st.recordPar "a"
      @st.recordPar "b"
      @st.recordPar "c"
      assert_equal @st.showPar(1), "c"
    end
    
    test "showParent" do
      @st.parArr = %w(a b c)
      assert_equal(@st.showPar(1), "c")
      
    end
    
    test "addMember" do
      a = @st.addMember "doc", "head"
      assert_equal(a, "doc.addMember(head)\n")
    end
    
    test "addMember case 2" do
      a = @st.addMember "doc", "head", "footer"
      assert_equal(a, "doc.addMember(head)\ndoc.addMember(footer)\n")
    end

    test "addChild" do
      a = @st.addChild "doc", "meta"
      assert_equal(a, "doc.addChild(meta)\n")
    end

    test "addChild case 2" do
      a = @st.addChild "doc", "meta", "script"
      assert_equal(a, "doc.addChild(meta)\ndoc.addChild(script)\n")
    end

    test "recordResult" do
      @st.recordResult "a"
      @st.recordResult "b"
      assert_equal @st.showResult, "ba"
      
    end

    test "coden case 1" do
      @st.coden "a", $CHILD, "b"
      assert_equal @st.showResult, "a.addChild(b)\n"
    end
    
    test "coden case 2" do
      @st.coden "a", $MEMBER, "b"
      assert_equal @st.showResult, "a.addMember(b)\n"
    end
    test "coden case 3" do
      @st.coden "a", $CHILD, "b"      
      @st.coden "a", $MEMBER, "b"
      assert_equal @st.showResult, "a.addMember(b)\na.addChild(b)\n"
    end

    test "coden case use endMarkCoden" do
      @st.parArr = %w(a b c) #ex) a{b,c}, ...
      @st.coden "c", $ENDMARK, $MEMBER # c},
      assert_equal @st.parArr.last, "c"
    end
    
    test "coden case use endMarkCoden case 2" do
      @st.parArr = %w(a b c)             # ex) a{b,c}} ...
      @st.coden "c", $ENDMARK, $ENDMARK  # ex  c}}
      assert_equal @st.parArr.last, "b"
    end
    

    test "isElement case true" do
      assert_true @st.isElement "a"
    end
    test "isElement case false" do
      assert_false @st.isElement $MEMBER
    end
    
    
    # test "sample case 1" do
    #   t = "a,b"
    #  @st.structing t
      
    #   # p ">>>"
    #   # p @st.showResult
       
    #   assert_equal(@st.showResult, "a.addMember(b)\n")
    # end
    
    # test "sample case 2" do
    #   t = "a{b}"
    #   @st.structing t
    #   assert_equal @st.showResult, "a.addChild(b)\n"
      
    # end

    # test "sample case 3" do
    #   t = "a{b,c}"
    #   @st.structing t
    #   assert_equal @st.showResult, "b.addMember(c)\na.addChild(b)\n"
            
    # end

    test "sample case 4" do
      t = "a{b,c},d"
      @st.structing t
      assert_equal @st.showResult, "a.addMember(d)\nb.addMember(c)\na.addChild(b)\n"
            
    end

    test "sample case 5" do
      t = "a{b{c}},d"
      @st.structing t
      assert_equal @st.showResult, "a.addMember(d)\nb.addChild(c)\na.addChild(b)\n"
            
    end

    
    # test "prep long version " do
    #   b = <<-MEM2
    #       doctype {d1{d2}
    #             }
    #       head {h1{h2}
    #         h3
    #        } 
      
    #   MEM2
      
    #   assert_equal(prep(b), " doctype{d1{d2} } head{h1{h2} h3 } ")
    # end

    
  end

end


    ############## model case ###############

    # , member
    # {} child
    
    # doctype {d1{d2,d3}
    #                 },
    # head {h1{h2},
    #             h3
    #            }

    # <<~ME

    # doctype {
    #          meta,
    #           memo       
    # },
    # header {
    #         title,
    #         meta,
    #         script,
    #         p {
    #           test,
    #           sample,
    #         },
    #         div {
    #           des,
    #           h1,
    #         }

    # },
    # body{

    # },
    # footer{

    # }


    # ME
      

  
    
