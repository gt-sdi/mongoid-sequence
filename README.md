# Mongoid Sequence

Mongoid Sequence allows you to specify fields to behave like a sequence number (exactly like the "id" column in conventional SQL flavors).

## Credits

This gem was inspired by a couple of gists by [masatomo](https://gist.github.com/730677) and [ShogunPanda](https://gist.github.com/1086265).

## Usage

Include `Mongoid::Sequence` in your class and call `sequence(:field)`.

Like this:

```ruby
class Sequenced
	include Mongoid::Document
	include Mongoid::Sequence
	
	field :my_sequence, :type => Integer
	sequence :my_sequence
end

s1 = Sequenced.create
s1.sequence #=> 1

s2 = Sequenced.create
s2.sequence #=> 2 # and so on
```

It's also possible to make the `id` field behave like this:

```ruby
class Sequenced
	include Mongoid::Document
	include Mongoid::Sequence
	
	sequence :_id
end

s1 = Sequenced.create
s1.id #=> 1

s2 = Sequenced.create
s2.id #=> 2 # and so on
```

Subclasses can share their superclass sequenced field(s) and/or have their own sequenced field(s):
```ruby
class Sequenced
	include Mongoid::Document
	include Mongoid::Sequence
	
	field :my_sequence, :type => Integer
	sequence :my_sequence
end

class SubSequenced
  use_superclass_sequence

	field :my_sub_sequence, :type => Integer
	sequence :my_sub_sequence
end

s1 = Sequenced.create
s1.my_sequence #=> 1

s2 = SubSequenced.create
s2.my_sequence #=> 2 
s2.my_sub_sequence #=> 1

```

## Consistency

Mongoid::Sequence uses the atomic [findAndModify](http://www.mongodb.org/display/DOCS/findAndModify+Command) command, so you shouldn't have to worry about the sequence's consistency.

## Installation

Just add it to your projects' `Gemfile`:

```ruby
gem "mongoid-sequence"
```

<hr/>

Copyright © 2010 Gonçalo Silva, released under the MIT license
