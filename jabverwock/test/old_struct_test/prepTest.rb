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
    end

    # テストがpassedになっている場合に，テスト実行後に呼ばれる．テスト後の状態確認とかに使える
    def cleanup
      p :cleanup
    end

    # 毎回テスト実行後に呼ばれる
    def teardown
      p :treadown
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
      

  
    ############## function ###############

    $CHILD = "_c_"
    $MEMBER = "_m_"
    $ENDMARK = "_e_"
    
    def prep (str)
      ans =str.gsub(/\t/," ")
      ans = ans.gsub(/\n/,"").gsub(/\s/, "")
      
    end

    def arraying (str)
      # a{b,c{d},e},f
      # "{" => "_c_", "}" => "_e_", "," => "_m_"
      # => ["a", "_c_", "b", "_m_", "c","_c_","d", "_e_","_m_", "e","_e_", "_m_", "f"]
      ans = str.gsub(/{/," #{$CHILD} ").gsub(/,/," #{$MEMBER} ").gsub(/}/," #{$ENDMARK} ")
      ans.split()
    end
    
    def coden(l, c, r)
      case c
      when $CHILD
        addChild l,r
        recordParent l
      when $MEMBER
        addMember l,r
      when $ENDMARK
        parIndex += 1
        endMarkCoden r
      end
    end
    
    def endMarkCoden (lastCode)
      case lastCode
      when $ENDMARK
        parIndex += 1
      when $MEMBER
        showParent parIndex
      end
    end

    def showParent (index)
      pi = parArr.count - index
      if pi < 0
        assert_raise()
      end
      parArr[pi]
    end
    
    def recordParent (par)
      parArr << par      
    end
    
    def addMember(par, *mem)
      ans = ""
      mem.each do |m|
        ans << "#{par}.addMember(#{m})" << "\n"
      end
      ans
    end

    def addChild(par, *chi)
      ans = ""
      chi.each do |c|
        ans << "#{par}.addChild(#{c})" << "\n"
      end
      ans
    end
    
    ############## test ###############
    
    test "prep case space 1" do
      a = "doc, head"
      b = "doc,  head"
      assert_equal(prep(a), "doc,head")

    end

    test "prep case tab" do
      b = "doc,  \thead"
      assert_equal(prep(b), "doc,head")

    end

    test "prep case retuen " do
      t = "doc,\nhead"
      assert_equal(prep(t), "doc,head")

    end
    
    test "arraying case 1" do
      t = "a,b{c}"
      arr = arraying t
      ans = ["a", $MEMBER, "b", $CHILD, "c", $ENDMARK]
      assert_equal(arr, ans)
           
    end
    
    test "arraying case 2" do
      t = "doc,head{h1}"
      arr = arraying t
      ans = ["doc", $MEMBER, "head", $CHILD, "h1", $ENDMARK]
      assert_equal(arr, ans)
           
    end

    
  end

end
