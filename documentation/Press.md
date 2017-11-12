press cmd export html, css, js.

# method

## pressConfig (name: name, dist: dist )
press cmd setting.

*__name__* : string, export file name.  
*__dist__* : string, export path.

## press
export cmd.

## pressTo(name: name, dist: dist)
pressTo cmd call pressConfig cmd and press cmd.

*__name__* : string, export file name.  
*__dist__* : string, export path.

 ```ruby
  def self.bodier
    body = BODY.new
    a = A.new.contentIs("test").attr(:href,"www://")
    body.addChild a
    body
  end
  
  html = HTML.new
  html.addChild bodier

  html.pressConfig(name: 'indexPressed.html', dist: myPATH)
  html.press

or 

  html.pressTo(name: 'indexPressed.html', dist: myPATH)

 ```
>[result]
>>```
>><html>
>>    <body>
>>	    <a href="www://">test</a>
>>    </body>
>></html>
>>```
	
## pressInsert (*data)
if you use variable method,   
pressInsert cmd exchange variable to string.  
variable method see 'Variable' page.  

*__data__* : string method, varIs use.  
ex) "a".varIs "test"


 ```ruby
  def self.bodier
    body = BODY.new    

    p1 = P.new.contentIs "a".variable
    p2 = P.new.contentIs "b".variable
    
    body.addChildren p1,p2
    
    body
  end
  
  html = HTML.new
  html.addChild bodier

  html.pressConfig(name: 'indexPressed.html', dist: myPATH)
  html.pressInsert "a".varIs("test done"), "b".varIs( "test done again")

 ```
>[result]
>>```
>><html>
>>    <body>
>>   	<p>test done</p>
>>	    <p>test done again</p>
>>    </body>
>></html>
>>```
