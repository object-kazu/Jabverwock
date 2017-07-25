require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension



    # test "use case id"  do
    #   @css.name = "p id::#test cls::.sample"
    #   ans = @css.useSelectorTreat :id
    #   assert_equal ans, "#test"
    # end

    # test "useSelectorTreat case cls"  do
    #   @css.name = "p id::#test cls::.sample"
    #   ans = @css.useSelectorTreat :cls
    #   assert_equal ans, ".sample"
      
    # end

    # test "useSelectorTreat case id and cls"  do
    #   @css.name = "p id::#test cls::.sample"
    #   ans = @css.useSelectorTreat :cls, :id
    #   assert_equal ans, ".sample #test"
      
    # end

    # test "useSelectorTreat case name"  do
    #   @css.name = "p id::#test cls::.sample"
    #   ans = @css.useSelectorTreat :name
    #   assert_equal ans, "p"
      
    # end


    
    # test "useSelectorTreat case all-1"  do
    #   @css.name = "p id::#test cls::.sample"
    #   ans = @css.useSelectorTreat :name, :id, :cls
    #   assert_equal ans, "p #test .sample"
      
    # end

    # test "useSelectorTreat case all-2"  do
    #   @css.name = "p id::#test cls::.sample"
    #   ans = @css.useSelectorTreat
    #   assert_equal ans, "p #test .sample"
      
    # end

    # test "no id useSelectorTreat case name "  do
    #   @css.name = "p cls::.sample"
            
    #   ans = @css.useSelectorTreat :name
    #   assert_equal ans, "p"
      
    # end
    
    # test "no id useSelectorTreat case id "  do
    #   @css.name = "p cls::.sample"
            
    #   ans = @css.useSelectorTreat :id
    #   assert_equal ans, ""
      
    # end

    # test "no id useSelectorTreat case cls "  do
    #   @css.name = "p cls::.sample"
            
    #   ans = @css.useSelectorTreat :cls
    #   assert_equal ans, ".sample"
      
    # end


  #   test "combineSelectors" do
    #   c = CSS.new("ss").addMembers "s","h"
    #   assert_equal(c.name, "ss,s,h")
    # end
    
    # test "combineSelectors, no name" do
    #   c = CSS.new("").addMembers "s","h"
    #   assert_equal(c.name, "s,h")
    # end

    # test "add child selector" do
    #   c = CSS.new("").addChildren "s", "h"
    #   assert_equal(c.name, "s h")
    # end

  def self.header
    head = HEAD.new
    title = TITLE.new.contentIs "This is my first page"
    head.addChild title
    head
  end
  
  def self.bodier
    
    body = BODY.new    
    heading = HEADING.new(1).contentIs "This text is addMembers"
    heading.attr(:id, "example1")

    ## css selector -> addMembers
    c1 = CSS.new("ss").addMembers "tt","gg"
    c1.color "red"
    heading.addCss c1
    
    head2 = HEADING.new(2).contentIs "This text is addChildren"
    head2.attr(:id, "example2")

    ## css selector -> addChildren
    c2 = CSS.new("").addChildren "tt", "gg"
    c2.color "blue"
    head2.addCss c2
    
    body.addChildren heading, head2    
    body
  end
  
  html= HTML.new  
  html.addChildren header, bodier
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.myPATH)
  
  # # show diff
  KSUtil.myDiff
  

end
