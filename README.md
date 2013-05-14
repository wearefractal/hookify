![status](https://secure.travis-ci.org/wearefractal/hookable.png?branch=master)

## Information

<table>
<tr> 
<td>Package</td><td>hookable</td>
</tr>
<tr>
<td>Description</td>
<td>Middleware everything</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.4</td>
</tr>
</table>

## Usage

```coffee-script
Hookable = require 'hookable'

class Dog extends Hookable

  walk: (distance, cb) ->
    @runPre 'walk', [distance], (err) ->
      return cb err if err?
      # walk the dog
      @runPost 'walk', [distance], (err) ->
        return cb err if err?
        cb()
```

```coffee-script
sparky = new Dog

sparky.pre 'walk', (distance, next) ->
  # do stuff
  next()

sparky.post 'walk', (distance, next) ->
  sparky.drink()
  next()

sparky.walk (err) ->
  # err is an argument passed to next() in a middleware

```

## LICENSE

(MIT License)

Copyright (c) 2013 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
