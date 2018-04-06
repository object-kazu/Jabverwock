require "global/globalDef"

require "global/jw"
require "global/jw_CSS"
require "global/jw_CSS_JS"
require "global/jw_CSS_OPAL_JS"

require "js/jsObject"
require "opal/opalFileReader"
require "css/css"

module Jabverwock

  
  class JJ < JW_CSS_OPAL_JS    
    # class << self
    #   def initialize
    #     super
    #   end

    # end


    # all tags
    allTags = []
    allTags += KSUtil.oneTags
    allTags += KSUtil.singleTags
    
    allTags.map!(&:downcase)
    allTags.each do |kls|
      define_singleton_method(kls) do
        eval"#{kls.upcase}.new"      
      end
    end

  end
end
