---
description: >-
  Here are ten faux pas I often see in Ruby code. Learn to turn these
  idiosyncrasies into idioms.
---

# Ten Faux Pas Ruby Developers Should Not Make

As a contract Ruby developer, I am exposed to lots and lots of code. Some code is readable;  some obfuscated. Some code eschews whitespace, as if carriage returns were a scarce natural resource, while other code resembles a living room fashioned by Vincent Van Duysen. Code, like the people who author it, varies.&#x20;

Yet it's ideal to minimize variation. The mantra, "Convention Over Configuration" keeps Rails codebases very similar, and tools such as Rubocop can unify style across individual files and even projects. Much of the rest falls to Ruby idioms, those "structural forms peculiar to \[the] language."$$^1$$ For example, Ruby syntax is a collection of explicit idioms enforced by the interpreter.  Reopening a class to refine or expand it is an idiom, too. Idioms let us share our code.&#x20;

But not all Ruby idioms are dogmatic. Others are simply best practices, shorthand, and common usages --  "slang", "shop talk", or "terms of art" -- that experienced Ruby developers read and write. The more adept you are at recognizing and proffering idioms, the better your code will be.  Of course, learning idioms in Ruby is like learning idioms in any second spoken (or programming) language. It takes time and practice.&#x20;

For instance, the following blocks of code all achieve the same result, but one is idiomatic to Ruby.&#x20;

```ruby
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
