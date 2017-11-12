# Jabverwock
Experimental; Integrate HTML, CSS, Javascript.

## What is the Jabverwock?
Jabverwock is open source project to make web page using Ruby.

Final goal is "Do not use HTML, CSS, JS".  
(Of course, we need the knowlege of HTML, CSS, JS)


## Installation

Install Jabverwock at the command prompt if you haven't yet:

`$ gem install jabverwock`

Add this line to your application's Gemfile:

```ruby
gem 'jabverwock'
```

## How to use

### Simple example

make html file,

export file name is `n` and file path is `~/path`
  

 ```ruby
 #test.rb
 
 require 'jabverwock'
 
 class Test
  include Jabverwock

  doc = DOCTYPE.new
  doc.pressConfig(name: n, dist: ~/path/)
  doc.press
  
 end
 
 Test.new
 ```

at command prompt  
`$ ruby test.rb`



```html:n.html
<!-- ~/path/n.html -->

<!DOCTYPE html>
```  

## Usœage and Documentation
More detailed usage instructions are provided in the [Wiki](https://github.com/object-kazu/Jabverwock/wiki).

## License
Jabverwock is distributed under MIT license.

Copyright (c) 2016 Kazuyuki Shimizu

