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


simple example


### => press

press command(cmd) export html ( css,  js ) generated by ruby.


+ pressConfig (name: name, dist: path)
	+ 	name: file name
	+ dist: path of file

+ press
	+ press command need pressConfig


pressTo cmd is more simple.

+ pressTo (name: name, dist: dist)
	+ name: file name
	+ dist: path of file

 ```ruby
	doc.pressTo(name: n, dist: ~/path)
 ```

 <br>

---
### Then, Hello world

Tag make by new cmd (e.g. HTML tag).

 ```ruby
  HTML.new
 ```

<br>
Say 'Hello world'


```ruby
html= HTML.new
head = HEAD.new

title = TITLE.new
title.content = "This is my first page"
head.addChild title

body = BODY.new
c = P.new.contentIs "Hello world!"
body.addChild c

html.addChild head
html.addChild body

doc = DOCTYPE.new
doc.addMember html

doc.pressTo(name: 'indexPressed.html', dist: myPATH)

```

>[result]
>>```html
>>	<!DOCTYPE html>
>>	<html>
>>		<head>
>>			<title>This is my first page</title>
>>		</head>
>>		<body>
>>			<p>Hello world!</p>
>>		</body>
>>	</html>
>>```