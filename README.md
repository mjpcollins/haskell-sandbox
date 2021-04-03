# haskell-sandbox
Playing around with some Haskell then comparing it to Python, Cython, C, 
Go, and Rust.

## The Problem

There are features which belong in families.  One can only select
one feature in each family. This is the most fundamental constraint.

There are other constraints. These constraints affect which 
features can be selected with each other. These constraints consist
of a list of feature-family-requirement data. Within a constraint
a feature can either be required (single character Y: "Y") or 
banned (empty string: ""). To check one constraint you must check
all the feature-family-requirement data. A constraint is considered
met if none of the feature-family-requirement statements are broken.

A constraint is a group of feature-family-requirements.

A rule is a group of constraints. 

A rule is considered "ok" if at least one of the constraints are 
not broken with the current feature and family configuration.

All rules must have at least one "ok" route through them.

## The code versions

I have created 4 different solutions to the problem.
1. Haskell (and Haskell with Ints)
2. Python
3. Cython
4. C
5. Go
6. Rust

### Haskell

This was an interesting version to code. The support on stackoverflow
was frustrating and good responses to common issues were hard to come by.

[Learn You a Haskell for Great Good](http://learnyouahaskell.com) by Miran Lipovaca
is an excellent resource. They have a book you can buy, but have also generously 
published it online for free.

The final product is quite nice to read through, very short, and incredibly fast.

On my machine it ran 1,000,000 checks across all the rules in 1.13 seconds

### Haskell Ints

Changing the feature types from strings to ints gives a 1,000,000 checks time 
of 0.89 seconds.

### Python

Once I had coded the Haskell version I knew the structure I wanted for the 
program. I use Python a fair amount, so this only took a few minutes to code up
and have working. While not super beautiful to look through, it is reasonably
short. 

Python is slow however. It takes 7.81 seconds to run 1,000,000 checks across all the rules.

### Cython

I haven't used Cython in a while, so I forgot how easy it was to set up.

I pretty much copy and pasted the basic [building code](https://cython.readthedocs.io/en/latest/src/quickstart/build.html)
and it worked.

That small adjustment led to halving the run time. For 1,000,000 all rule checks it
took 3.21 seconds.


### C

C is just awkward.

The support online is very good, but segmentation faults are a right pain to debug.

I do not think the code I have produced here is particularly well optimised,
and it took much longer for me to code this up than the other versions. In addition,
the code ended up around 130 lines compared to Python and Haskell both at around 45 lines.

However, it takes 1.57 seconds to run 1,000,000 all rule checks. 

This is a pretty good run time, but about 0.4 seconds slower than Haskell.

### Go

Wow. This language is _not bad_. Coding up is a little bit like javascript, but
on the whole not too painful. 

The speed is incredible. 0.11 seconds to do 1000000 rule check cycles.

It is so fast that I suspect it might be doing some sneaky caching and not actually
running the code. 

Go is awesome - but treating speed as suspiciously fast...

### Rust

Rust takes a bit to get your head around. Ownership of variables is a bit fiddly, but
got there in the end. Perforance is better than C, but strangely worse than Go. 

Clocks in at 0.75 seconds for 1000000 rule check cycles.

## Testing Rig

 - **Model Name**: MacBook Pro 
 - **Model Identifier**: MacBook Pro 17,1 
 - **Chip**: Apple M1 
 - **Total Number of Cores**: 8 (4 performance and 4 efficiency)
 - **Memory**: 16 GB 




