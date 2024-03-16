# Five Things to Avoid in Ruby

**_Here are five faux pas often seen in Ruby code. Learn how to turn
these idiosyncrasies into idioms._**

As a contract software developer, I am exposed to oodles of Ruby code. Some code is readable, some obfuscated. Some code eschews whitespace, as if carriage returns were a scarce natural resource, while other code resembles a living room fashioned by Vincent Van Duysen. Code, like the people who author it, varies. Yet it's ideal to minimize variation. Time and effort are best spent on novel problems.

Ruby developers can gain efficiency with Rubocop, which unifies style within a single project or across many projects. Rails is a boon to uniformity, too, as it favors convention over configuration. Indeed, disparate Rails codebases are identical in places and, overall, quite similar.

Beyond tools and convention, variance is also minimized by idioms, or those "structural forms peculiar to \[the] language."[^1] For example, Ruby syntax is a collection of explicit idioms enforced by the interpreter. Reopening a class is a Ruby idiom, too.

But not all Ruby idioms are dicta. Most Ruby idioms are best practices, shorthand, and common usages Ruby developers share informally and in practice.

Learning idioms in Ruby is like learning idioms in any second spoken (or programming) language. It takes time and practice. Yet the more adept you are at recognizing and proffering Ruby's idioms, the better your code will be.

## Avoid Verbosity

If you've delved any into Ruby, you can appreciate how expressive, compact, fun, and flexible it is. Any given problem can be solved in a number of ways. For example, `if`/`unless`, `case`, and the ternary operator `?:` all express decisions and which to apply depends on the problem.

However, per Ruby idiom, some `if` statements are better than others. For instance, the following blocks of code achieve the same result, but one is idiomatic to Ruby.

```ruby
# Verbose approach

actor = nil

if response == 1
  actor = "Groucho"
elsif response == 2
  actor = "Chico"
elsif response == 3
  actor = "Harpo"
else
  actor = "Zeppo"
end
```

```ruby
# Idiomatic approach

actor =
  if response == 1
    "Groucho"
  elsif response == 2
    "Chico"
  elsif response == 3
    "Harpo"
  else
    "Zeppo"
  end
```

Almost every Ruby statement and expression yields a value, including `if`, which returns the value of the final statement of code of the matching condition. The latter version of the `if` statement code leverages this behavior. If `response` is `2`, `actor` is set to `Chico`. Assigning the result of an `if` statement is idiomatic to Ruby. (The same construct can be applied to `case`, `unless`, `begin/end`, and others.)

There is another Ruby idiom present: you need not predefine a variable used within an `if` statement (or`while`,  `for`, and others). So, the latter code removes the line `actor = nil`. In Ruby, unlike other languages, the body of  an `if` statement is _not_ considered a block for scope.

## Avoid long expressions to detect `nil`

`nil` represents "nothing" in Ruby. It's a legitimate value and is its own class (`NilClass`) with methods. Like other classes, if you call a method not defined on `nil`, Ruby throws an exception akin to `undefined method 'xxx' for nil:NilClass`.

To avoid this exception, you must first test a value to determine if it's `nil.` If the value is a reference to a structure, you may also have to test if the structure is `nil`, and so on.

For example, code such as this is common in Rails applications:

```ruby
if user && user.plan && user.plan.name == 'Standard'
  # ... some code for the Standard plan
end
```

The trouble is such a long chain of assertions is unwieldy. Imagine having to repeat the condition `user && user.plan && ...` every time you have to reference the user's plan name.

Instead, use Ruby's safe navigation operator, `&.` It is shorthand for "If a method is called on `nil`, return `nil`; otherwise, call the method as normal."  Using `&.`the code above reduces to the much more readable...

```ruby
if user&.plan&.name == 'Standard`
  // ... some code
end
```

If `user` is `nil` and `plan` is `nil`, the expression `user&.plan&.name` is `nil`.

The example above assumes `user` and `plan` represent a custom structure or Rails model of some kind. You can also use the safe navigation operator if a value  represents an `Array` or `Hash.`For example, assume `a_list_of_values` is an `Array`...

```ruby
a_list_of_values[index]
```

If `a_list_of_values` is `nil`, an exception is thrown. If you expectantly try `a_list_of_values&.[index]`, a syntax error occurs. Instead, use `&.` with the `Array#at` method.

```ruby
a_list_of_values&.at(index)
```

Now, if `a_list_of_values` is `nil`, the result of the expression is `nil`.

## Avoid overuse of `self`

Ruby uses `self` in three substantive ways:

1. To define class methods
2. To refer to the current object
3. To differentiate between a local variable and a method if both have the same name

Here's an example class demonstrating all three usages.

```ruby
class Rectangle
  def self.area(length, width)
    new(length, width).area
  end

  def self.volume(length, width, height)
    area(length, width) * height
  end

  def initialize(length, width, height = nil)
    self.length = length
    self.width  = width
    self.height = height
  end

  def area
    length * width
  end

  def volume
    area = 100
    self.area * height
  end

  private

  attr_reader :length, :width, :height
end
```

`def self.area` is an example of the first purpose for `self`, defining a class method. Given this class, the Ruby code `puts Rectangle.area(10, 5)` produces `50`.

The code `self.length = length` demonstrates the second application of `self`: the instance variable `length` is set to the value of the argument `length`. (The `attr_reader` statement at bottom defines the instance variable and provides a getter method.) Here, the statement `self.length = length` is functionally the same as `@length = length`.

The third use of `self` is shown in the `volume` method. What does `puts Rectangle.volume(10, 5, 2)` emit?
The answer is `100`. The line `area = 100` sets a method-scoped, local variable named `area`. However,
the line `self.area` refers to the method `area`. Hence, the answer is `10 * 5 * 2 = 100`.

Consider one more example. What is the output if the `volume` method is written like this:

```ruby
 def volume
   height = 10
   self.area * height
end
```

The answer is `500` because both uses of `height` refer to the local variable, not the instance variable.

Inexperienced Rails developers make unnecessary use of `self`, as in:

```ruby
# Class User
# first_name: String
# last_name: String
# ...

class User < ApplicationRecord
  ...
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
```

Technically, this code is correct, yet the uses of `self` to refer to the attributes of
the model are unnecessary. If you combine Rubocop with your development environment, Rubocop
flags this issue for you to correct.

### Avoid collecting results in temporary variables

A common code chore is processing lists of records. You might eliminate records due to some
criteria; map one set of values to another; or separate one set of records into multiple categories.
A typical solution is to iterate over the list and accumulate a result. For instance, consider
this a solution to find all even numbers from a list of integers:

```ruby
def even_numbers(list)
  even_numbers = []

  list.each do [number]
    even_numbers << number if number&.even?
  end

  return even_numbers
end
```

The code creates an empty list to aggregate results and then iterates over the list,
ignoring `nil` items, and accumulating the even values. Finally, it returns the list to the caller.
This code serves the purpose, but isn't idiomatic.

A better approach is to use Ruby's Enumerable methods.

```ruby
def even_numbers(list)
  even_numbers.select(&:even?) # shorthand for `.select { |v| v.even? }`
end
```

`select` is one of many Enumerable methods. Each Enumerable method iterates
over a list and collects results based on a condition. Specifically, `select`
iterates over a list and accumulates all items where a condition yields a _truthy_ value.
In the example above, `even?` returns `true` if the item is an even number.
`select` returns a new list, leaving the original list unchanged. A variant named
`select!` performs the same purpose but alters (mutates) the original list.

The Enumerable methods include `reject` and `map` (also known as `collect`).
`reject` collects all items from a list where a condition yields a falsey value;
`map` returns a new list where each item is the original list is transformed by
some expression.

Here's one more example Enumerable method in action. First, some non-idiomatic code:

```ruby
def transform(hash)
  new_hash = {}

  hash.each_pair do |key, value|
    new_hash[key] = value ? value * 2 : nil
  end

  return new_hash
end
```

And now a more idiomatic approach:

```ruby
def transform(hash)
  hash.transform_values { |value| value&.*(2) }
end
```

`transform_values` is another Enumerable method available for `Hash`. It returns
a new hash with the same keys but where each associated value is transformed.
Remember even integers are objects in Ruby and have methods. `value&.*(2)`
returns `nil` if `value` is `nil` else `value * 2`.

### Sorting and filtering in memory

One last faux pas, this one specific to Rails and ActiveRecord. Let's examine this code:

```ruby
# class Student
# name: String
# gpa: Float
# ...
#

class Student < ApplicationRecord
  ...

  def self.top_students
    Student
      .all
      .sort_by { |score| student.gpa }
      .select { |score| student.gpa >= 90.0 }
      .reverse
  end
end
```

Calling `Student.top_students` returns all students with a GPA greater than or equal to `90.0`
in ranked order from highest to lowest. Technically, this code is correct, but it isn't very
efficient in space or time.

* It must load all records from the `students` table into memory
* It first sorts all records and _then_ filters based on GPA, performing unnecessary work
* It reverses the order of the list in memory

Sorting and filtering are best performed in the database, if possible, using ActiveRecord's
tools.

```ruby
def self.top_students
  Student.where(gpa: 90.0..).order(gpa: :desc)
end
```

The shorthand `90.0..` in the `where` clause is a Ruby `Range` expressing a value
between `90.0` and `Float::INFINITY`. If `gpa` is indexed in the `students` table,
this query is likely very fast and loads only the matching records. If the student
records are being fetched for display, more efficiency (in memory) can be gained
via pagination (albeit at the possible expense of more queries to fetch the batches.)

### Next Steps

I highly recommend reading the documentation for Ruby's core classes and modules, including `Array`, `Hash`, and `Enumerable.` The documents are a treasure trove of methods and techniques, and chances are a method exists to solve your problem at-hand. Turn knowledge into practice by wrting small code samples to learn how each method works.

Add Rubocop into your workflow, even your text editor. Rubocop keeps your code looking nice, but it can also flag idiosyncratic code. Writing code with Rubocop assistance is one of the best ways to learn to code the Ruby way.

Finally, read other developers' code, especially open source Ruby projects. To peruse the code of any gem, run `bundle open <gem>`, where `<gem>` is the name of a library. If you've included a debugger in your _Gemfile_, you can even set breakpoints in any gem and step through code.

[^1]: This definition comes from [Merriam-Webster Online](https://www.merriam-webster.com/dictionary/idiom).
