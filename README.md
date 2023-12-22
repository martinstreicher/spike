---
description: >-
  Here are ten faux pas I often see in Ruby code. Learn to turn these
  idiosyncrasies into idioms.
---

# Ten Faux Pas Ruby Developers Should Not Make

As a contract software developer, I am exposed to lots and lots of Ruby code. Some code is readable, some obfuscated. Some code eschews whitespace, as if carriage returns were a scarce natural resource, while other code resembles a living room fashioned by Vincent Van Duysen. Code, like the people who author it, varies. Yet it's ideal to minimize variation. Time and effort are best spent on novel problems.&#x20;

Ruby developers can gain efficiency with Rubocop, which unifies style across files in a single project or across many projects. Rails is a boon, too, as it favors convention over configuration. Rails codebases are identical in places and overall quite similar. &#x20;

Beyond tools and convention, variance is also minimized by idioms, or those "structural forms peculiar to \[the] language."$$^1$$ For example, Ruby syntax is a collection of explicit idioms enforced by the interpreter. Reopening a Ruby class to refine or expand it is a Ruby idiom, too.&#x20;

But not all Ruby idioms are are dogma. Most Ruby idioms are best practices, shorthand, and common usages -- "slang" or "terms of art" -- Ruby developers share informally and in practice.  The more adept you are at recognizing and proffering Ruby's idioms, the better your code will be. &#x20;

Learning idioms in Ruby is like learning idioms in any second spoken (or programming) language. It takes time and practice.&#x20;

***

### Gimme an example

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

Almost every Ruby statement yields a value, including `if`, which returns the value of the final statement of the block in the matching condition. The latter version of the `if` statement code leverages this behavior. If `response` is `2`, `actor` is set to `Chico`. Assigning the result of an `if` statement is idiomatic to Ruby.&#x20;

Here are ten examples of non-idiomatic Ruby code I often see and how to rewrite them like a "local".&#x20;

***

### Long expressions to avoid \`nil\`

`nil` represents "nothing" in Ruby. It's a legitimate value, is its own class (`NilClass`), and has methods. Like other classes, if you call a method not defined on `nil`, Ruby throws an exception akin to `undefined method 'xxx' for nil:NilClass`.&#x20;

To avoid this exception, you must first test a value to determine if it's `nil.`If the value references another value, you may have to test for `nil` again. For example, code such as this is both common and required:

```ruby
if user && user.plan && user.plan.name == 'Standard'
  // ... come code
end 
```

The trouble is that such a long chain of assertions is unwieldy. Imagine having to repeat the same condition every time you have to reference the user's plan name.&#x20;

Instead, use Ruby's safe navigation operator, `&.`It is shorthand for "If a method is called on nil, return nil; otherwise, call the method as normal."  The code above reduces to the much more readable...

```ruby
if user&.plan&.name == 'Standard`
  // ... some code
end
```

If `user` is `nil` and `plan` is `nil`, the expression `user&.plan&.name` is `nil`. &#x20;

An aside: The example above assumes `user` and `plan` represent a custom class instance of some kind. Can you use the safe navigation operator if thee value represents an `Array` or `Hash`? For example...

```
a_list_of_values[index]
```

If `a_list_of_values` is `nil`, an exception is thrown. If you try `a _list_of_values&.[index]`, a syntax error occurs. Instead, use `&.` combined with the `Array#at` method.&#x20;

```
a_list_of_values&.at(index)
```

***

### Using \`self\` to refer to self

### Collecting results in temporary variables

A common application problem is processing lists of information.  Code may eliminate records due to some criteria; map some value to another value; or separate records from one list to multiple lists. In each of those tasks, you must accumulate a result set.&#x20;

Consider this a solution to pick out all even numbers from a list of integers.

```ruby
def even_numbers(list)
  even_numbers = [] 

  list.each do [number]
    even_numbers << number if number&.even?
  end

  return even_numbers
end
```

### Sorting and filtering in memory

### Next Steps

I highly recommend reading the documentation for Ruby's core classes and modules, including `Array`, `Hash`, and `Enumerable.` Each is a trove of tools and chances are you can find a handy implement to slice and dice your data.&#x20;

Also, intergrate Rubocop into your workflow, even your text editor. Rubocop keeps your code looking nice, but it can also point out where code is idiosyncratic. Writing code with Rubocop assistance is one of the best ways to create the Ruby way.&#x20;

***

&#x20;$$^1$$This definition comes from [Merriam-Webster Online](https://www.merriam-webster.com/dictionary/idiom).&#x20;

