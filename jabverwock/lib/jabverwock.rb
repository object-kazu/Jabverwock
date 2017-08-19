$FOR_GEM = false

require "jabverwock/version"

if $FOR_GEM
  
  require 'global/globalDef'
  require 'global/jw'
  require 'global/jwMulti'
  require 'global/jwOneTag'
  require 'global/jwSingle'
  require 'global/jwTable'
  require 'global/jw_CSS'
  require 'global/jw_CSS_JS'
  require 'global/press'
    
else

  require 'global/globalDef'
  require 'global/jw'
  require 'global/jwMulti'
  require 'global/jwOneTag'
  require 'global/jwSingle'
  require 'global/jwTable'
  require 'global/jw_CSS'
  require 'global/jw_CSS_JS'
  require 'global/press'

end




# > gem uninstall jabverwock
# > rake build
# > gem install -l pkg/jabverwock-xxxx


# require 'jabverwock'

# class Test
#   using StringExtension
#   include Jabverwock

#   p P.new
# end
