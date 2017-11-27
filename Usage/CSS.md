# Class CSS
1. HTML class include css class.  
2. header tag required.
   * css is insert in head tag so that you should 'add (child | member) head'.  
3. import css class as variable.   
   *  when css imported, css name is override.  

---
> example : css is not exported  

```ruby
#sample.rb

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end
  
  def self.bodier
    body = BODY.new    
    heading = HEADING.new(1).contentIs "Home page"
    heading.css.color("green")
    
    body.addChild heading
    
    body
  end
  
  html= HTML.new
  
  #html.addChild header  <===
  html.addChild bodier

```

```html
<- ~/path/result.html ->


<html>
	<body>
		<h1>Home page</h1>
	</body>
</html>


```

---
> example : css is exported  

```ruby
#sample.rb

  def self.header
   ***
  end
  
  def self.bodier
   ***
  end
  
  html= HTML.new
  
  html.addChild header <===
  html.addChild bodier


```

```html
<- ~/path/result.html ->

<html>
	<head>
		<title>This is my first page</title>
		<style>
			h1 {
				color: green;
			}
		</style>
	</head>
	<body>
		<h1>Home page</h1>
	</body>
</html>

```

# method
## initilize (name)
**name** : string or symbol, css name 

---
> example  

```ruby
#sample.rb

CSS.new "head"

or

CSS.new :head

```

```html
<- ~/path/result.html ->

 head{...}

```

if you should use complicated css name, string is easy way.

---
> example  

```ruby
#sample.rb

c = css.new ""
c.name = "div.sample h2 ~ p"
c.color = "red"


```

```html
<- ~/path/result.html ->

 ***
 div.sample h2 ~ p { color: red;}
 ***

```


## defualt name rule
css defualt name is depended on HTML class.

---
> example  

```ruby
#sample.rb

  def self.header
   ***
  end

  def self.bodier
    ***
	
	heading = HEADING.new(1).contentIs "Home page"
    heading.css.color("green")

    heading2 = HEADING.new(2).attr(:id__test).contentIs "About page"
    heading2.css.color "blue"

    heading3 = HEADING.new(3).attr(:id__test, :cls__sample).contentIs "Contact page"
    heading3.css.color "white"
    
    body.addChildren heading, heading2, heading3
	
	***
  end

  ***

```

```html
<- ~/path/result.html ->
	
	***
		<style>
			h1 {
				color: green;
			}
			h2 {
				color: blue;
			}
			h3 {
				color: white;
			}
		</style>
	***

```

## name
set name of css.  
but, css class require name at initilizing.  
if you want to use name method, write like following code.

---
> example  

```ruby
#sample.rb

c = CSS.new ""
c.name = "head"
c.font_size = 10

```

```html
<- ~/path/result.html ->

head {\nfont-size: 10;}"

```

symbol with double-underbar
":id__" is id selector

---
> example  

```ruby
#sample.rb

CSS.new(:id__test).color "red"

```

```html
<- ~/path/result.html ->

#test {\ncolor: red;}"

```

---
> example: another expression  

```ruby
#sample.rb

   c = CSS.new("").color "red"
   c.name = :id__test

```

```html
<- ~/path/result.html ->

	#test {\ncolor: red;}"

```

":cls__" is class selector

---
> example  

```ruby
#sample.rb

CSS.new(:cls__test).color "red"

```

```html
<- ~/path/result.html ->

.test {\ncolor: red;}"

```

	
## addCss (css)
import css class to HTML classes.  
**css** : css class

if you use addCss method, css name is override.

---
> example  

```ruby
#sample.rb

  def self.header
   ***
  end
    
  def self.bodier
    body = BODY.new    
    heading = HEADING.new(1).contentIs "This text is red"
    heading.attr(:id, "example1")
    body.addChild heading
    body
  end
  
  html= HTML.new.attr(:id__example2)
  
  c = CSS.new("#example1").color "blue"
  html.addCss c
  
  html.addChildren header, bodier

```

```html
<- ~/path/result.html ->

<html id="example2">
	<head>
		<title>This is my first page</title>
		<style>
			#example1 {
				color: blue;
			}
		</style>
	</head>
	<body>
		<h1 id="example1">This text is red</h1>
	</body>
</html>

```

## dpName
copy css name.

---
> example  

```ruby
#sample.rb

html= HTML.new.attr(:id__example2)
c = CSS.new("#example1").color "blue"
  
changed = CSS.new ""
changed.name = c.dpName
changed.color "red"
html.addCss changed
  
```

```html
<- ~/path/result.html ->

<style>
	#example1 {
		color: red;
		}	 
</style>


```

## addChildrenName
connect css name by space.

---
> example  

```ruby
#sample.rb

c = CSS.new("#example1").color "blue"
  
cAdd = CSS.new c.addChildrenName ".sample"
cAdd.background_color "black"

```

```html
<- ~/path/result.html ->

<style>
	#example1 {
		color: blue;
		}
	#example1 .sample {
		background-color: black;
		}
</style>


```


## addMembersName
connect css name by commma.

---
> example  

```ruby
#sample.rb

c = CSS.new("#example1").color "blue"
    
cAdd = CSS.new c.addMembersName ".sample"
cAdd.background_color "white"
  
html.addCss c, cAdd

```

```html
<- ~/path/result.html ->

#example1 {
	color: blue;
	}
	
#example1, .sample {
	background-color: white;
	}


```


## css properties
css property is method.

---
> example  

```ruby
#sample.rb

  html= HTML.new.attr(:id__example2)
  c = CSS.new("#example1").color("blue").font_size "10"
  html.addCss c

```

```html
<- ~/path/result.html ->

		<style>
			#example1 {
				color: blue;
				font-size: 10;
			}
		</style>


```
