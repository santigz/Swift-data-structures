//
//  Queue.swift
//
//  Copyright (c) 2015 Santiago González.
//
// Notes for Swift beginners:
// - SequenceType protocol (formerly called Sequence) makes possible the use of for-in loop.
//   Read http://robots.thoughtbot.com/swift-sequences and http://schani.wordpress.com/2014/06/06/generators-in-swift/
//

import Foundation


/**
    Container that inserts and removes elements in LIFO (last-in first-out) order. New elements are added at the tail and removed from the head. Subscripting and looping go from front to back.
    
    You can choose if the queue will behave as a linked list or a circular array.


    ## Use

    Create a Queue as a linked list:

        var queue = Queue<LinkedList<Int>>()!

    Create a Queue as a circular array:

        var queue = Queue<CircularArray<Int>>(capacity: 10)!
    
    Choosing the wrong initializer returns `nil`:

        Queue<LinkedList<Int>>(capacity: 10)  // returns nil
        Queue<CircularArray<Int>>() // returns nil



    ## Implementation details

    Queue can be implemented as CircularArray or LinkedList, but we don't want Queue to inherit from them so that it's more clear that Queue is only intended to be used as a LIFO: Queue shouldn't allow `pushFront` and `popBack`.

    However, Queue is just a thin wrapper for a `DoubleEndedContainer`, so if you need

    It's somewhat tricky to make this in Swift:

    - Queue can't inherit from `DoubleEndedContainer` because it has associated types.
    - Queue can't have `var container: DoubleEndedContainer` because of associated types.
    
    But we can have `DoubleEndedContainer` as a generic type. The drawback is that we can't have at compilation time the concrete type of the container. This means that our initializers may fail and return nil, but that's an acceptable consequence.

 */
class Queue<C: DoubleEndedContainer>: Container {
    
    // Basic type of the elements
    typealias Element = C.Generator.Element
    
    /// The container of the queue. It's optional because initializers may fail, but once the queue is initialized, the container is never nil.
    var container: C? = nil
    
    /// Initializer for LinkedList
    init?() {
        self.container = LinkedList<Element>() as? C
        if self.container == nil {
            return nil
        }
    }
    
    /// Initializer for CircularArray
    init?(capacity: Int) {
        self.container = CircularArray<Element>(capacity: capacity) as? C
        if self.container == nil {
            return nil
        }
    }
    
    /// Whether the queue is empty
    var isEmpty: Bool {
        return container!.isEmpty
    }
    
    /// Number of elements in the queue
    var count: Int {
        return container!.count
    }
    
    /// Element at the back the queue
    var back: Element? {
        return container!.back
    }
    
    /// Element at the front the queue
    var front: Element? {
        return container!.front
    }
    
    /// Remove all elements in the queue
    func removeAll() {
        container!.removeAll()
    }
    
    /// Enqueue a new element at the tail
    func pushBack(item: Element) {
        container!.pushBack(item)
    }
    
    /// Dequeue an element from the head, returning it
    func popFront() -> Element? {
        return container!.popFront()
    }
}

/**
    Double ended queue.
    A queue allowing push and pop at front and back.
 */
class Dequeue<C: DoubleEndedContainer>: Queue<C> {
    /// Insert a new element at the front
    func pushFront(item: T) {
        container!.pushFront(item)
    }

    /// Dequeue an element from the tail, returning it
    func popBack() -> T? {
        return container!.popBack()
    }
}
