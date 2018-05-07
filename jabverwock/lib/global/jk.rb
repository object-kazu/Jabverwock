require "global/globalDef"

module Jabverwock

  
  class JK

    # all tags
    allTags = KSUtil.allTags
    
    # JK.DIV convert to JK.div
    allTags.map!(&:downcase)
    
    #example: JK.div equal to DIV.new
    allTags.each do |kls|
      define_singleton_method(kls) do
        eval"#{kls.upcase}.new"      
      end
    end

    # Heading tag only, beacase heading need arg
    hing = KSUtil.headingList
    hing.map!(&:downcase)
    hing.each do |kls|
      define_singleton_method(kls) do |arg| 
        eval"#{kls.upcase}.new(arg)"      
      end
    end
    
  end
end
