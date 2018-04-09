require "global/globalDef"

module Jabverwock

  
  class JK

    # all tags
    allTags = []
    allTags += KSUtil.oneTags
    allTags += KSUtil.singleTags
    allTags += KSUtil.multiTags
    allTags += KSUtil.tableTags
    
    # JK.DIV convert to JK.div
    allTags.map!(&:downcase)
    
    # JK.div equal to DIV.new
    allTags.each do |kls|
      define_singleton_method(kls) do
        eval"#{kls.upcase}.new"      
      end
    end

  end
end
