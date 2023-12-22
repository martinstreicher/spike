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

If you've delved any into Ruby, you can appreciate how expressive, compact, fun, and flexible it is. Any given problem can be solved in a number of ways. For example, `if`/`unless`, `case`, and the ternary operator `?:` all express decisions and what to apply depends on the problem.&#x20;

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

Almost every Ruby statement yields a value, including `if`, which returns the value of the final statement of the body in the matching condition. The latter block of code leverages this behavior. If `response` is `2`, `actor` is set to `Chico`. The latter block is idiomatic to Ruby.&#x20;

Here are ten more examples of non-idiomatic Ruby code I often see and how to rewrite them like a "local".&#x20;

***

### Long expressions to check for \`nil\`

`nil` represents "nothing" in Ruby. It's a legitimate value, is its own class (`NilClass`), and thus has methods. Like other classes, if you call a method not defined on `nil`, Ruby throws an exception akin to `undefined method 'sort' for nil:NilClass`.&#x20;

$$^1$$ This definition comes from [Merriam-Webster Online](https://www.merriam-webster.com/dictionary/idiom).&#x20;

