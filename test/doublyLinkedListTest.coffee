{DoublyLinkedList} = require('../')

exports.doublyLinkedListTest =

  testConstructor: (test) ->
    myList = new DoublyLinkedList()
    test.equal(myList.length, 0)
    test.equal(myList.head, null)
    test.equal(myList.tail, null)

    test.done()

  testPush: (test) ->
    myList = new DoublyLinkedList()

    myList.push(1)
    test.equal(myList.length, 1)
    test.equal(myList.head.value, 1)
    test.equal(myList.tail.value, 1)

    myList.push(2)
    test.equal(myList.length, 2)
    test.equal(myList.head.value, 1)
    test.equal(myList.tail.value, 2)

    myList.push(3)
    test.equal(myList.length, 3)
    test.equal(myList.head.value, 1)
    test.equal(myList.tail.value, 3)

    test.done()

  testUnshiftPopAndShift: (test) ->
    myList = new DoublyLinkedList()
    myList.push(200)
    myList.push(300)
    myList.unshift(100)
    myList.push(400)
    test.deepEqual(myList.toArray(), [100, 200, 300, 400])

    test.equal(myList.shift(), 100)
    test.equal(myList.pop(), 400)
    test.equal(myList.pop(), 300)
    test.equal(myList.shift(), 200)

    test.done()

  testInsertAfter: (test) ->
    myList = new DoublyLinkedList([1, 2, 4, 5, 7, 8])
    current = myList.head
    while current.value != 2
      current = current.after
    current.insertAfter(3)
    test.deepEqual(myList.toArray(), [1, 2, 3, 4, 5, 7, 8])

    myList.tail.insertAfter(9)
    test.deepEqual(myList.toArray(), [1, 2, 3, 4, 5, 7, 8, 9])

    myList.head.insertAfter(1.5)
    test.deepEqual(myList.toArray(), [1, 1.5, 2, 3, 4, 5, 7, 8, 9])

    test.done()

  testInsertBefore: (test) ->
    myList = new DoublyLinkedList([1, 2, 3, 4, 5, 7, 8])
    current = myList.tail
    while current.value != 7
      current = current.before
    current.insertBefore(6)
    test.deepEqual(myList.toArray(), [1, 2, 3, 4, 5, 6, 7, 8])

    test.done()

  testRemove: (test) ->
    myList = new DoublyLinkedList([1, 2, 3, 4, 5, 6, 7, 8])
    current = myList.tail
    while current.value != 7
      current = current.before
    current.remove()
    test.deepEqual(myList.toArray(), [1, 2, 3, 4, 5, 6, 8])

    current = myList.tail
    current.remove()
    test.deepEqual(myList.toArray(), [1, 2, 3, 4, 5, 6])

    current = myList.head
    current.remove()
    test.deepEqual(myList.toArray(), [2, 3, 4, 5, 6])

    test.done()

  testConstructionWithArray: (test) ->
    a = [1, 2, 3]
    myList = new DoublyLinkedList(a)
    test.deepEqual(myList.toArray(), a)
    
    test.done()