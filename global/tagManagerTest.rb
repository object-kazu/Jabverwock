require 'test/unit'
require './globalDef' 
require './tagManager' 

class TagManagerTest < Test::Unit::TestCase
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
    p $SPC  
  end
  
  test "TagManager, path confirm " do
    tm =  TagManager.new 
    tm.name = "first"

    assert_equal(tm.openString, "<first>")
    assert_equal(tm.closeString, "</first>")
    
  end
  
  # test "TagManager, name is void " do
  #   tm =  TagManager.new()
  #   tm.name = ""

  #   assert_equal(tm.openString, "")
    
  # end

  # test "id add" do
  #   tm =  TagManager.new()
  #   tm.id = "test"

  #   assert_equal(tm.openString, "id=\"test\"")
    
  # end

  # test "id and name add" do
  #   tm =  TagManager.new()
  #   tm.id = "test"
  #   tm.name = "sample"

  #   assert_equal(tm.openString, "name=\"sample\" id=\"test\"")
    
  # end

  # test "class  add" do
  #   tm =  TagManager.new()
  #   tm.cls = "test"

  #   assert_equal(tm.openString, "class=\"test\"")
    
  # end

  # test "class, id , name  add" do
  #   tm =  TagManager.new()
  #   tm.cls = "test"
  #   tm.id = "test"
  #   tm.name = "sample"

  #   assert_equal(tm.openString, "name=\"sample\" id=\"test\" class=\"test\"" )

  # end

  
end

# >> Loaded suite /var/folders/w8/tp2v81_s3f3g44st06_hgy0c0000gn/T/seeing_is_believing_temp_dir20170126-37194-12osl0g/program
# >> Started
# >> :_startup
# >> :setup
# >> E
# >> ===============================================================================
# >> Error: test: TagManager, path confirm (TagManagerTest):
# >>   NameError: undefined local variable or method `addName' for #<TagManager:0x007f9fe19773a8>
# >>   Did you mean?  addSpace
# >> /Users/shimizukazuyuki/ActiveProject/JabberWockProjects/JabverwockRuby/global/tagManager.rb:51:in `openString'
# >> /var/folders/w8/tp2v81_s3f3g44st06_hgy0c0000gn/T/seeing_is_believing_temp_dir20170126-37194-12osl0g/program.rb:42:in `block in <class:TagManagerTest>'
# >> ===============================================================================
# >> :treadown
# >> :setup
# >> " "
# >> :cleanup
# >> :treadown
# >> .:_shutdown
# >> 
# >> 
# >> Finished in 0.003605 seconds.
# >> ------
# >> 2 tests, 0 assertions, 0 failures, 1 errors, 0 pendings, 0 omissions, 0 notifications
# >> 50% passed
# >> ------
# >> 554.79 tests/s, 0.00 assertions/s
