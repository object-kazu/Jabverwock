# method
## variable
string method (e.g. "a".variable).  
set variable.
if you can not set string using varIs method,  
variable equal ''.

## varIs (str)
exchange variable to string.
use with pressInsert method.

*__str__* : string, variable value. 

 ```ruby
  html = HTML.new  
  body = BODY.new
  
  p1 = P.new.contentIs "this is " << "a".variable
  
  body.addChild p1
  html.addChild body
      
  html.pressConfig(name: 'indexPressed.html', dist: myPATH)
  html.pressInsert("a".varIs "class")

 ```
>[result]
>>```
>><html>
>>    <body>
>>  	<p>this is class</p>
>>    </body>
>></html>
>>```
