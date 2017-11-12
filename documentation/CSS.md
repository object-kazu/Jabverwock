# Class CSS
1. HTML class include css class.  
  * css infulence HTML tag.  
2. if HTML class pressed,   
   css is insert in head tag so that you should 'add (child | member) head'.  
3. import css class as variable.   
   *  when css imported, css name is override.  


header tag need.  
 ```ruby
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
>[result] css is not exported
>>```
>><html>
>>	<body>
>>		<h1>Home page</h1>
>>	</body>
>></html>
>>```

 ```ruby
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
>[result] css(style tag) exported
>>```
>><html>
>>	<head>
>>		<title>This is my first page</title>
>>		<style>
>>			h1 {
>>				color: green;
>>			}
>>		</style>
>>	</head>
>>	<body>
>>		<h1>Home page</h1>
>>	</body>
>></html>
>>```

# method
## initilize (name)
*__name__* : string or symbol, css name 

 ```ruby
CSS.new "head"

or

CSS.new :head
 ```
>[result]
>>```
>> head{...}
>>```

if you should use complicated css name, string is easy way.

 ```ruby

c = css.new ""
n = "div.sample h2 ~ p"
c.name = n
c.color = "red"

 ```
>[result]
>>```
>> ***
>>div.sample h2 ~ p { color: red;}
>> ***
>>```


## defualt name rule
css defualt name is depended on HTML class.

 ```ruby
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
>[result]
>>```
>>		<style>
>>			h1 {
>>				color: green;
>>			}
>>			h2 {
>>				color: blue;
>>			}
>>			h3 {
>>				color: white;
>>			}
>>		</style>
>>```


## name
set name of css.  
but, css class require name at initilizing.  
if you want to use name method, write like following code.

 ```ruby
      c = CSS.new ""
      c.name = "head"
      c.font_size = 10
 ```
>[result]
>>```
>>head {\nfont-size: 10;}"
>>```


symbol with double-underbar
":id__" is id selector
 ```ruby
   CSS.new(:id__test).color "red"

 ```
>[result]
>>```
>>#test {\ncolor: red;}"
>>```

another expression
 ```ruby
   c = CSS.new("").color "red"
   c.name = :id__test

 ```
>[result]
>>```
>>#test {\ncolor: red;}"
>>```

":cls__" is class selector
 ```ruby
   CSS.new(:cls__test).color "red"

 ```
>[result]
>>```
>>.test {\ncolor: red;}"
>>```



	
## addCss (css)
import css class to HTML classes.  
*__css__* : css class

if you use addCss method, css name is override.

 ```ruby
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
>[result]
>>```
>><html id="example2">
>>	<head>
>>		<title>This is my first page</title>
>>		<style>
>>			#example1 {
>>				color: blue;
>>			}
>>		</style>
>>	</head>
>>	<body>
>>		<h1 id="example1">This text is red</h1>
>>	</body>
>></html>
>>```

## dpName
copy css name.

 ```ruby
 html= HTML.new.attr(:id__example2)
  c = CSS.new("#example1").color "blue"
  
  changed = CSS.new ""
  changed.name = c.dpName
  changed.color "red"
  html.addCss changed
  
 ```


## addChildrenName
connect css name by space.


 ```ruby
 c = CSS.new("#example1").color "blue"
  
 cAdd = CSS.new c.addChildrenName ".sample"
 cAdd.background_color "black"

 ```
>[result]
>>```
>>		<style>
>>			#example1 {
>>				color: blue;
>>			}
>>			#example1 .sample {
>>				background-color: black;
>>			}
>>		</style>
>>```


## addMembersName
connect css name by commma.

 ```ruby
 c = CSS.new("#example1").color "blue"
    
 cAdd = CSS.new c.addMembersName ".sample"
 cAdd.background_color "white"
  
 html.addCss c, cAdd
  
 ```
>[result]
>>```
>>			#example1 {
>>				color: blue;
>>			}
>>			#example1, .sample {
>>				background-color: white;
>>			}
>>```


## css properties
css property is method.

 ```ruby
 ***
  
  html= HTML.new.attr(:id__example2)
  c = CSS.new("#example1").color("blue").font_size "10"
  html.addCss c

 ***
 ```
>[result]
>>```
>>		<style>
>>			#example1 {
>>				color: blue;
>>				font-size: 10;
>>			}
>>		</style>
>>```

