[![build status](https://secure.travis-ci.org/lmaccherone/DoublyLinkedList.png)](http://travis-ci.org/lmaccherone/DoublyLinkedList)

# DoublyLinkedList #

Copyright (c) 2012, Lawrence S. Maccherone, Jr.

_A doubly linked list implementation in CoffeeScript._

## Credits ##

* Author: [Larry Maccherone](http://maccherone.com) (<Larry@Maccherone.com>)

## Usage ##

**DoublyLinkedList** is an implementation of a doubly linked list in CoffeeScript.
    
Instantiate it empty or with an array.

    {DoublyLinkedList} = require('./')
    list = new DoublyLinkedList([1, 2, 3])
    console.log(list.toString())
    # 1,2,3
    
Push stuff onto the end or unshift stuff onto the beginning.

    list.push(4)
    list.unshift(0)
    console.log(list.toString())
    # 0,1,2,3,4
    
Pop and shift.

    last = list.pop()
    first = list.shift()
    console.log(list.toString())
    # 1,2,3
    console.log(first, last)
    # 0 4
    
Maybe someday I'll implement a true iterator. In the mean time, you can walk before and after.

    current = list.head
    while current?
      console.log(current.value)
      current = current.after
    # 1
    # 2
    # 3
    
Insert before or after.

    list.head.after.insertBefore(1.5)
    list.tail.before.insertAfter(2.5)    
    console.log(list.toString())
    # 1,1.5,2,2.5,3    

## Installation ##

Add `"DoublyLinkedNode":"0.1.x"` to the dependencies property in your `config.json` and run `npm install`

## Changelog ##

* 0.1.0 - 2012-11-11 - Original version
* 0.1.1 - 2012-11-11 - Simpler toString() and added usage

## MIT License ##

Copyright (c) 2012, Lawrence S. Maccherone, Jr.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.