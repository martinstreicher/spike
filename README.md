---
description: >-
  Here are ten faux pas I often see in Ruby code. Learn to turn these
  idiosyncrasies into idioms.
---

# Ten Faux Pas Ruby Developers Should Not Make

As a contract software developer, I am exposed to lots and lots of Ruby code. Some code is readable, some obfuscated. Some code eschews whitespace, as if carriage returns were a scarce natural resource, while other code resembles a living room fashioned by Vincent Van Duysen. Code, like the people who author it, varies. Yet it's ideal to minimize variation. Time and effort are best spent on novel problems.&#x20;

Ruby developers can gain efficiency with a tool such as Rubocop, which unifies style across individual files in a single project and even across many projects. Rails boosts cognition, too, favoring convention over configuration. Rails codebases are identical in places and overall quite similar. &#x20;

Beyond tools and convention, variance is also minimized by idioms, or those "structural forms peculiar to \[the] language."$$^1$$ For example, Ruby's syntax is a collection of explicit idioms enforced by the interpreter. Reopening a Ruby class to refine or expand it is a Ruby idiom, too.&#x20;

But not all Ruby idioms are so dogmatic. Most Ruby idioms are best practices, shorthand, and common usages -- "slang" or "terms of art", if you will -- Ruby developers share informally to collaborate on code.  The more adept you are at recognizing and proffering Ruby's idioms, the better your code will be. &#x20;

Learning idioms in Ruby is like learning idioms in any second spoken (or programming) language. It takes time and practice.&#x20;

***

### Gimme an example

If you've delved any into Ruby, you can appreciate how expressive, compact, fun, and flexible it is. For example, `if`/`unless`, `case`, and the ternary operator `?:` all express decisions and which to apply depends on the problem.&#x20;

However, per Ruby idiom, some `if` statements are better than others.&#x20;

For instance, the following blocks of code achieve the same result, but one is idiomatic to Ruby. &#x20;

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

Here are ten examples of Ruby code that are not idiomatic and how to rewrite them like a "local".&#x20;

$$^1$$ This definition comes from [Merriam-Webster Online](https://www.merriam-webster.com/dictionary/idiom).&#x20;

