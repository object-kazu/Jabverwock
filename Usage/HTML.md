# HTML tags express by class.

JabberWock class name is eqaul to HTML tag name.
*(following examples need to add press cmd)*

---
#### overview
``` ruby
# smaple.rb

doc = DOCTYPE.new
doc.pressTo (name: result, dist: ~/path)

```
  
> $ ruby sample.rb
  
  
```html
<- ~/path/result.html ->

<!DOCTYPE html>

```

## method
### new (level=1)
Making tag ( = make instance).  
Level is only need in the case of Heading tag.  
In other tags, level is ignored.  

**level** :  int (1 ~ 6), heading level.

---
> example  

```ruby
#sample.rb

html = HTML.new

```

```html
<- ~/path/result.html ->

<html>
</html>

```


### content (str)
add content to tag.  
**str** : string, tag content


---
> example  

```ruby
# sample.rb

pp = P.new
pp.content = "Hello world!"

or

pp = P.new.contentIs "Hello world!"


```

```html
<- ~/path/result.html ->

<p>Hello world!</p>

```

### addChild (elem)
**elem** : element, add child element.


---
> example  

```ruby
#sample.rb
head = HEAD.new
html.addChild head

```

```html
<- ~/path/result.html ->
<html>
	<head>
	</head>
</html>

```


### addChildren (*elem)
**elem** : array, adding some elements.

---
> example 1 

```ruby
#sample.rb

head = HEAD.new
body = BODY.new
html.addChildren head, body

```

```html
<- ~/path/result.html ->
	<html>
		<head>
		</head>
		<body>
		</body>
	</html>
```
  
---
> example 2

```ruby
#sample.rb

 $PAGES =  %w(home about contact)

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.aList    
    arr = []
    $PAGES.each do |a|
      tdash = "www:" << a
      t = A.new.contentIs(a.capitalize).attr(:href, tdash)
      arr << t
    end
    arr
  end
  
  def self.bodier
    body = BODY.new    
    heading = HEADING.new(1).contentIs 'This is addChildren test'
    
    body.addChild heading
    body.addChildren aList    
    body
  end
  
  html= HTML.new
  html.addChildren header, bodier


```

```html
<- ~/path/result.html ->

<html>
   <head>
     <title>This is my first page</title>
   </head>
   <body>
     <h1>This is addChildren test</h1>
     <a href="www:home">Home</a>
     <a href="www:about">About</a>
     <a href="www:contact">Contact</a>	
    </body>
</html>

```



### addMember (elem)
**elem** : element, add it as member.


---
> example  

```ruby
#sample.rb
   html.addMember head
```

```html
<- ~/path/result.html ->
	<html>
	</html>
	<head>
	</head>

```

## addMembers (*elem)
**elem** : adding some elements.


---
> example  

```ruby
#sample.rb
head = HEAD.new
body = BODY.new
html.addMembers head, body

or

html.addMembers [head, body]

```

```html
<- ~/path/result.html ->
	<html>
	</html>
	<head>
	</head>
	<body>
	</body>

```

### tgStr
HTML tag class can export as string.
you want to write case of tag in tag.

---
> example 1  

```ruby
#sample.rb
bold = B.new.contentIs "test"

pp = P.new.contentIs "This is #{bold.tgStr}"
body.addChild pp

```

```html
<- ~/path/result.html ->
<p>This is <b>test</b></p>

```

---
> example 2  

```ruby
#sample.rb

  a = A.new.contentIs("test").attr(:href,"www://")
  pp = P.new.contentIs "What is this? #{a.tgStr}"

  body = BODY.new
  body.addChild pp

  html= HTML.new  
  html.addChild body

```

```html
<- ~/path/result.html ->

<html>
	<body>
		<p>What is this? <a href="www://">test</a></p>
	</body>
</html>


```


## class
### Heading
`<h1> ~ <h6>`  
heading tag can use argument for the level.

---
> example  

```ruby
#sample.rb

html= HTML.new

body = BODY.new
h1 = HEADING.new.contentIs "Hello world!"
h2 = HEADING.new(2).contentIs "See you again"

body.addChildren h1,h2
html.addChild body

```

```html
<- ~/path/result.html ->

<html>
    <body>
		<h1>Hello world!</h1>
		<h2>See you again</h2>
    </body>
</html>


```


### Break
`<br>`  
you can insert break tag by two way.  
one is use Class (tgStr), another is string (Global constant, $BR).


---
> example 1  

```ruby
#sample.rb

br = BR.new
p1 = P.new.contentIs "this is " << br.tgStr << "br class"
p2 = P.new.contentIs "this is #{$BR}br string"

body.addChildren p1, p2

```

```html
<- ~/path/result.html ->

<p>this is <br>br class</p>
<p>this is <br>br string</p>


```

br tag sometimes need for end of tag.  
withBreak method is useful.


---
> example  

```ruby
#sample.rb

p3 = P.new.contentIs("this is last").withBreak

```

```html
<- ~/path/result.html ->

<p>this is last</p><br>

```

br tag also has content.  

---
> example  

```ruby
#sample.rb

br = BR.new.contentIs "this is test"

```

```html
<- ~/path/result.html ->

this is test<br>

```
