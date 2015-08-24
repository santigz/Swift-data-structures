//
//  Queue.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Foundation

/**
    Container that inserts and removes elements in LIFO (last-in first-out) order. New elements are added at the tail and removed from the head.
*/
protocol QueueType: Container {
    
    /// Element at the back the container
    var back: Self.Generator.Element? { get }
    
    /// Element at the front the container
    var front: Self.Generator.Element? { get }
    
    /// Enqueue a new element at the tail
    mutating func pushBack(item: Self.Generator.Element)
    
    /// Dequeue an element from the head, returning it
    mutating func popFront() -> Self.Generator.Element?
}


/**
    The default implementation of a Queue is a linked list.
    You can change the default behaviour by changing the superclass to `CircularArrayQueue`.
 */
class Queue<T>: LinkedListQueue<T> {}


/**
    Implementation of a queue as a circular array. The whole implementation is delegated to `CircularArray`. We do not inherit from it to avoid exposing its whole implementation as a safety mechanism (queues are not expected to allow `pushFront()` or `popBack()`). Subscripting and looping go from front to back.
 */
class CircularArrayQueue<T>: QueueType {
    
    internal var delegate: CircularArray<T>
    
    /// Initialize as a new circular array with a given capacity
    init(capacity: Int) {
        delegate = CircularArray<T>(capacity: capacity)
    }
    
    /// Initialize from a circular array
    init(circularArray: CircularArray<T>) {
        delegate = circularArray
    }
    
    /// Returns the underlying circular array
    var circularArray: CircularArray<T> {
        get {
            return delegate
        }
    }
    
    // MARK: Container
    
    /// Whether the container is empty
    var isEmpty: Bool {
        return delegate.isEmpty
    }
    
    /// Number of elements in the container
    var count: Int {
        return delegate.count
    }
    
    /// Remove all elements in the container
    func removeAll() {
        delegate.removeAll()
    }
    
    
    // MARK: Queue
    
    /// Element at the back the queue
    var back: T? {
        return delegate.back
    }
    
    /// Element at the front the queue
    var front: T? {
        return delegate.front
    }
    
    /// Enqueue a new element at the tail
    func pushBack(item: T) {
        delegate.pushBack(item)
    }
    
    /// Dequeue an element from the head, returning it
    func popFront() -> T? {
        return delegate.popFront()
    }
}


/**
    Make CircularArrayQueue iterable.
*/
extension CircularArrayQueue: MutableCollectionType {
    /// Always zero
    var startIndex: Int {
        return delegate.startIndex
    }
    
    /// Equal to the number of elements in the array
    var endIndex: Int {
        return delegate.endIndex
    }
    
    /// The position must be within bounds. Otherwise it might crash. Complexity: O(1)
    subscript (position: Int) -> T {
        get {
            return delegate[position]
        }
        set {
            delegate[position] = newValue
        }
    }
    
    func generate() -> CircularArrayGenerator<T> {
        return delegate.generate()
    }
}


/**
    Implementation of a queue as a circular array. The whole implementation is delegated to `LinkedList`. We do not inherit from it to avoid exposing its whole implementation as a safety mechanism (queues are not expected to allow `pushFront()` or `popBack()`).
*/
class LinkedListQueue<T>: QueueType {
    
    internal var delegate: LinkedList<T>
    
    /// Initialize as a new linked list
    init(capacity: Int) {
        delegate = LinkedList<T>()
    }
    
    /// Initialize from a linked list
    init(linkedList: LinkedList<T>) {
        delegate = linkedList
    }
    
    /// Returns the underlying linked list
    var linkedList: LinkedList<T> {
        get {
            return delegate
        }
    }
    
    // MARK: Container
    
    /// Whether the container is empty
    var isEmpty: Bool {
        return delegate.isEmpty
    }
    
    /// Number of elements in the container
    var count: Int {
        return delegate.count
    }
    
    /// Remove all elements in the container
    func removeAll() {
        delegate.removeAll()
    }
    
    
    // MARK: Queue
    
    /// Element at the back the queue
    var back: T? {
        return delegate.back
    }
    
    /// Element at the front the queue
    var front: T? {
        return delegate.front
    }
    
    /// Enqueue a new element at the tail
    func pushBack(item: T) {
        delegate.pushBack(item)
    }
    
    /// Dequeue an element from the head, returning it
    func popFront() -> T? {
        return delegate.popFront()
    }
}


/**
    Make LinkedListQueue iterable.
*/
extension LinkedListQueue: MutableCollectionType {
    /// Always zero
    var startIndex: Int {
        return delegate.startIndex
    }
    
    /// Equal to the number of elements in the array
    var endIndex: Int {
        return delegate.endIndex
    }
    
    /// The position must be within bounds. Otherwise it might crash. Complexity: O(1)
    subscript (position: Int) -> T {
        get {
            return delegate[position]
        }
        set {
            delegate[position] = newValue
        }
    }
    
    func generate() -> LinkedListGenerator<T> {
        return delegate.generate()
    }
}
