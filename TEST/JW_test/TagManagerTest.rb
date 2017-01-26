require 'test/unit'
require '../../GLOBAL/GlobalDef'# => true
require '../../GLOBAL/TagManager'# => 

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
  
  test "TagManager, path confirm " do
    tm =  TagManager.new()
    tm.name = "first"

    assert_equal(tm.openString, "name=\"first\"")
    
  end
  
  test "TagManager, name is void " do
    tm =  TagManager.new()
    tm.name = ""

    assert_equal(tm.openString, "")
    
  end

  test "id add" do
    tm =  TagManager.new()
    tm.id = "test"

    assert_equal(tm.openString, "id=\"test\"")
    
  end

  test "id and name add" do
    tm =  TagManager.new()
    tm.id = "test"
    tm.name = "sample"

    assert_equal(tm.openString, "name=\"sample\" id=\"test\"")
    
  end

  test "class  add" do
    tm =  TagManager.new()
    tm.cls = "test"

    assert_equal(tm.openString, "class=\"test\"")
    
  end

  test "class, id , name  add" do
    tm =  TagManager.new()
    tm.cls = "test"
    tm.id = "test"
    tm.name = "sample"

    assert_equal(tm.openString, "name=\"sample\" id=\"test\" class=\"test\"" )

  end

  
end

# ~> LoadError
# ~> cannot load such file -- ./GlobalDef
# ~>
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /Users/shimizukazuyuki/ActiveProject/JabberWockProjects/JabverwockRuby/GLOBAL/TagManager.rb:1:in `<top (required)>'
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /var/folders/w8/tp2v81_s3f3g44st06_hgy0c0000gn/T/seeing_is_believing_temp_dir20170126-86140-psaaej/program.rb:3:in `<main>'
