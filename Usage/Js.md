# Class Js
Js property express the javascript.
To insert js script, head class required.
You can insert script as following methods.

1. js is expressed by html class function.
2. js can inport javascript files.
3. js can inport opal files.

## 1. function

js property use.
every jabverwock class has js property.
js codes were collect and write in head tag at press command called.

---
> example 1  

```ruby
#sample.rb

	...
	
    html = HTML.new

    header = HEAD.new
    title = TITLE.new.contentIs "hello world"
    header.addChild title
    
    header.js.doc.write("hello!")
    
    body = BODY.new
    body.js.doc.write("new world")
    
    html.addChild header
    html.addChild body

	...

```

```html
<- ~/path/result.html ->

<html>
    <head>
	<title>hello world</title>
    </head>
    <body>
	<script>
	 document.write('hello!');
	 document.write('new world');
	</script>
    </body>
</html>

```

---
> example 2  

```ruby
#sample.rb

class << self
	def bodier
	body = BODY.new

	h1 = HEADING.new.attr(:id__id1).contentIs "My Heading 1"
	h1s = h1.js.doc.byID.style(color:"red").cut
        
	btn = BUTTON.new.attr(:type__button, :onclick, h1s).contentIs "Click Me!"
        
	body.addChildren [h1, btn]
	body
	end      
end
    
    
html = HTML.new
    
html.addChild bodier


```

```html
<- ~/path/result.html ->
<html>
    <body>

	<h1 id="id1">My Heading 1</h1>
	<button type="button" onclick="document.getElementById('id1').style.color='red'">Click Me!</button>

    </body>
</html>


```

## 2. javascript files


## 3. opal files




