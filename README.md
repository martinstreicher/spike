---
description: >-
  Here are ten faux pas I often see in Ruby code. Learn how to turn these
  idiosyncrasies into idioms.
---

# Ten Things to Avoid in Ruby

As a contract software developer, I am exposed to lots and lots of Ruby code. Some code is readable, some obfuscated. Some code eschews whitespace, as if carriage returns were a scarce natural resource, while other code resembles a living room fashioned by Vincent Van Duysen. Code, like the people who author it, varies. Yet it's ideal to minimize variation. Time and effort are best spent on novel problems.&#x20;

Ruby developers can gain efficiency with Rubocop, which unifies style within a single project or across many projects. Rails is a boon to uniformity, too, as it favors convention over configuration. Rails codebases are identical in places and, overall, quite similar. &#x20;

Beyond tools and convention, variance is also minimized by idioms, or those "structural forms peculiar to \[the] language."$$^1$$ For example, Ruby syntax is a collection of explicit idioms enforced by the interpreter. Reopening a class is a Ruby idiom, too.&#x20;

But not all Ruby idioms are dicta. Most Ruby idioms are best practices, shorthand, and common usages Ruby developers share informally and in practice.  &#x20;

Learning idioms in Ruby is like learning idioms in any second spoken (or programming) language. It takes time and practice.  The more adept you are at recognizing and proffering Ruby's idioms, the better your code will be. &#x20;

***

### Avoid Verbosity

If you've delved any into Ruby, you can appreciate how expressive, compact, fun, and flexible it is. Any given problem can be solved in a number of ways. For example, `if`/`unless`, `case`, and the ternary operator `?:` all express decisions and which to apply depends on the problem.&#x20;

However, per Ruby idiom, some `if` statements are better than others. For instance, the following blocks of code achieve the same result, but one is idiomatic to Ruby. &#x20;

```
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

Almost every Ruby statement and expression yields a value, including `if`, which returns the value of the final statement of the block in the matching condition. The latter version of the `if` statement code leverages this behavior. If `response` is `2`, `actor` is set to `Chico`. Assigning the result of an `if` statement is idiomatic to Ruby. (The same construct can be applied to `case`, `unless`, `begin/end`, and others.

Here are nine more examples of non-idiomatic Ruby code I often see and how to rewrite them like a "local".&#x20;

***

### Avoid long expressions to avoid \`nil\`

`nil` represents "nothing" in Ruby. It's a legitimate value and is its own class (`NilClass`) with methods. Like other classes, if you call a method not defined on `nil`, Ruby throws an exception akin to `undefined method 'xxx' for nil:NilClass`.&#x20;

To avoid this exception, you must first test a value to determine if it's `nil.`If you use a value to reference a structure, you may also have to test if the reference is `nil`, and so on. For example, code such as this is common in Rails applications:

```ruby
if user && user.plan && user.plan.name == 'Standard'
  // ... come code
end 
```

The trouble is such a long chain of assertions is unwieldy. Imagine having to repeat the same condition every time you have to reference the user's plan name.&#x20;

Instead, use Ruby's safe navigation operator, `&.`It is shorthand for "If a method is called on `nil`, return `nil`; otherwise, call the method as normal."  Using `&.`the code above reduces to the much more readable...

```ruby
if user&.plan&.name == 'Standard`
  // ... some code
end
```

If `user` is `nil` and `plan` is `nil`, the expression `user&.plan&.name` is `nil`. &#x20;

The example above assumes `user` and `plan` represent a custom structure or Rails model of some kind. You can also use the safe navigation operator if a value  represents an `Array` or `Hash.`For example, assume `a_list_of_values` is an `Array`...&#x20;

```
a_list_of_values[index]
```

If `a_list_of_values` is `nil`, an exception is thrown. If you expectantly try `a_list_of_values&.[index]`, a syntax error occurs. Instead, use `&.` with the `Array#at` method.&#x20;

```
a_list_of_values&.at(index)
```

Now, if `a_list_of_values` is `nil`, the result of the expression is `nil`.&#x20;

***

### Avoid using `self` to refer to self

Ruby uses `self` in three different substantive ways:

* To define class methods
* To refer to the current instance of an object&#x20;
* To differentiate between a local variable and a method if both have the same name&#x20;

Here's an example of the first usage, defining a class method...

```ruby
class Rectangle 
  def self.area(length, width)
  end 
end 
```

### Avoid collecting results in temporary variables

A common code chore is processing lists of records. You might eliminate records due to some criteria; map each value to another value; or separate one set of records into multiple lists. A typical solution is to iterate over the list and accumulate a separate result set. Consider this a solution to pick out all even numbers from a list of integers...

```ruby
def even_numbers(list)
  even_numbers = [] 

  list.each do [number]
    even_numbers << number if number&.even?
  end

  return even_numbers
end
```

The code creates an empty list to aggregate results and then iterates over the list, accumulating the even values. Finally, it returns the list. This code serves the purpose, but isn't idiomatic. A better approach is to use Ruby's enumerable methods.&#x20;

```
def even_numbers(list)
  even_numbers.select(&:even?) # shorthand for `.select { |v| v.even? }`
end 
```

`select` iterates over each element in the list and chooses those where even is true`.`

Here's another approach useful for more complicated transforms.&#x20;

```
// Some code
```

### Sorting and filtering in memory

Sorting  lists to manipulating

### Next Steps

I highly recommend reading the documentation for Ruby's core classes and modules, including `Array`, `Hash`, and `Enumerable.` Each is a trove of tools, and chances are a method exists to  solve your problem. Turn knowledge into practice by wrting small code samples to learn how each method works. &#x20;

Add Rubocop into your workflow, even your text editor. Rubocop keeps your code looking nice, but it can also flag idiosyncratic code. Writing code with Rubocop assistance is one of the best ways to learn to code the Ruby way.&#x20;

Finally, read other developers' code, especially open source Ruby projects. To peruse the code of any gem, run `bundle open <gem>`, where `<gem>` is the name of a library. If you've included a debugger in your _Gemfile_, you can even set breakpoints in any gem and step through code.&#x20;

***

&#x20;$$^1$$This definition comes from [Merriam-Webster Online](https://www.merriam-webster.com/dictionary/idiom).&#x20;

