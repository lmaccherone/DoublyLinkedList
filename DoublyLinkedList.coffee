###


###
class DoublyLinkedList

  constructor: (initialValues) ->
    @head = null
    @tail = null
    @length = 0
    if initialValues?
      for value in initialValues
        @push(value)

  push: (value) ->
    if @tail?
      @tail.insertAfter(value)
    else
      @tail = new DoublyLinkedNode(value, this)
      @head = @tail
      @length++
    return @length

  unshift: (value) ->
    if @head?
      @head.insertBefore(value)
    else
      @head = new DoublyLinkedNode(value, this)
      @tail = @head
      @length++
    return @length

  pop: () ->
    return @tail.remove().value

  shift: () ->
    return @head.remove().value

  ###
  @method invoke
  @chainable
  Calls func on each value in the list. Inside the function, "this" will be set to this node including access
  to before, after, list, value, etc. The first parameter sent into the function will be the value for this node.
  @param func The function to be called on each value in the list
  @param [args] Any additional parameters that you want passed in when calling func
  ###
  invoke: (func, args...) ->
    current = @head
    args.unshift(current?.value)
    while current?
      func.apply(this, args)
      current = current.after
      args[0] = current?.value
    return this

  ###
  @method toArray
  Returns the values as an array
  ###
  toArray: () ->
    a = []
    current = @head
    while current?
      a.push(current.value)
      current = current.after
    return a

  toString: () ->
    s = "head: #{@head}"
    current = @head
    while current?
      s += current.toString()
      current = current.after
    s += "tail: #{@tail}"
    return s

  print: () ->
    console.log(@toString())

###
@class DoublyLinkedNode
Node class for DoublyLinkedList
###
class DoublyLinkedNode

  ###
  @constructor
  You should generally not need to call this constructor. Instead use insertBefore() and insertAfter().
  ###
  constructor: (@value, @list, @before = null, @after = null) ->

  ###
  @method insertAfter
  Creates a new node and inserts it in the list after this node.
  @param {Object} value
  @return {DoublyLinkedNode} The newly created node
  ###
  insertAfter: (value) ->
    newNode = new DoublyLinkedNode(value, @list, this, @after)
    if @after?
      @after.before = newNode
    @after = newNode
    if @list.tail == this
      @list.tail = @after
    @list.length++
    return @after

  ###
  @method insertBefore
  Creates a new node and inserts it in the list before this node.
  @param {Object} value
  @return {DoublyLinkedNode} The newly created node
  ###
  insertBefore: (value) ->
    newNode = new DoublyLinkedNode(value, @list, @before, this)
    if @before?
      @before.after = newNode
    @before = newNode
    if @list.head == this
      @list.head = @before
    @list.length++
    return @before

  ###
  @method remove
  Removes this node from the list and returns its value
  ###
  remove: () ->
    if @before?
      @before.after = @after
    else
      @list.head = @after
    if @after?
      @after.before = @before
    else
      @list.tail = @before
    @before = null
    @after = null
    @list--
    return this

  toString: () ->
    return "{value: #{@value}, before: #{@before?.value}, after: #{@after?.value}}\n"

exports.DoublyLinkedNode = DoublyLinkedNode
exports.DoublyLinkedList = DoublyLinkedList