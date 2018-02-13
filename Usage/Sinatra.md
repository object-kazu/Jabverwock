# Usage with sinatra.


``` ruby
# app.rb

require 'sinatra'
require 'sinatra/reloader'
require 'jabverwock'

get '/' do
  pp = P.new.contentIs "jabverwock come!"
  title = "indexPressed"
  pp.pressTo(name: "#{title}.erb", dist: "./views/")
  erb :indexPressed
end

```  

```console
bunlde exec ruby app.rb

```
