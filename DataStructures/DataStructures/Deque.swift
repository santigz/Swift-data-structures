//
//  Deque.swift
//  Data Structures
//
//  Created by Santiago González on 21/08/2015.
//  Copyright © 2015 sangonz. All rights reserved.
//

import Foundation

/**
    Double ended queue
*/
public protocol DequeType: QueueType {
    /// Element at the back the container
    var back: Self.Generator.Element? { get set }
    
    /// Element at the front the container
    var front: Self.Generator.Element? { get set }
    
    /// Insert a new element at the front
    mutating func pushFront(item: Self.Generator.Element)
    
    /// Remove an element from the back, returning it
    mutating func popBack() -> Self.Generator.Element?
}


/**
    Implementation of a deque as a circular array. The whole implementation is delegated to `CircularArray`.
*/
public struct CircularArrayDeque<T>: DequeType {
    
    internal var delegate: CircularArray<T>
    
    /// Initialize as a new circular array with a given capacity
    public init(capacity: Int) {
        delegate = CircularArray<T>(capacity: capacity)
    }
    
    /// Initialize from a circular array
    public init(circularArray: CircularArray<T>) {
        delegate = circularArray
    }
    
    /// Returns the underlying circular array
    var circularArray: CircularArray<T> {
        get {
            return delegate
        }
    }
    
    // MARK: Container protocol
    
    /// Whether the container is empty
    public var isEmpty: Bool {
        return delegate.isEmpty
    }
    
    /// Number of elements in the container
    public var count: Int {
        return delegate.count
    }
    
    /// Remove all elements in the container
    public mutating func removeAll() {
        delegate.removeAll()
    }
    
    // MARK: QueueType protocol
    
    /// Element at the back the queue. Assigning `nil` removes the back element.
    public var back: T? {
        get { return delegate.back }
        set { delegate.back = newValue }
    }
    
    /// Element at the front the queue. Assigning `nil` removes the front element.
    public var front: T? {
        get { return delegate.front }
        set { delegate.front = newValue }
    }
    
    /// Enqueue a new element at the tail
    public mutating func pushBack(item: T) {
        delegate.pushBack(item)
    }
    
    /// Dequeue an element from the head, returning it
    public mutating func popFront() -> T? {
        return delegate.popFront()
    }
    
    // MARK: DequeType protocol
    
    /// Insert a new element at the front
    public mutating func pushFront(item: T) {
        delegate.pushFront(item)
    }
    
    /// Dequeue an element from the tail, returning it
    public mutating func popBack() -> T? {
        return delegate.popBack()
    }
}

/**
    Make CircularArrayDeque iterable.
*/
extension CircularArrayDeque: MutableCollectionType {
    /// Always zero
    public var startIndex: Int {
        return delegate.startIndex
    }
    
    /// Equal to the number of elements in the array
    public var endIndex: Int {
        return delegate.endIndex
    }
    
    /// The position must be within bounds. Otherwise it might crash. Complexity: O(1)
    public subscript (position: Int) -> T {
        get {
            return delegate[position]
        }
        set {
            delegate[position] = newValue
        }
    }
    
    public func generate() -> CircularArrayGenerator<T> {
        return delegate.generate()
    }
}


/**
    Implementation of a deque as a linked list. The whole implementation is delegated to `LinkedList`.
*/
public struct LinkedListDeque<T>: DequeType {
    
    internal var delegate: LinkedList<T>
    
    /// Initialize as a new linked list
    public init(capacity: Int) {
        delegate = LinkedList<T>()
    }
    
    /// Initialize from a linked list
    public init(linkedList: LinkedList<T>) {
        delegate = linkedList
    }
    
    /// Returns the underlying linked list
    public var linkedList: LinkedList<T> {
        get {
            return delegate
        }
    }
    
    // MARK: Container protocol
    
    /// Whether the container is empty
    public var isEmpty: Bool {
        return delegate.isEmpty
    }
    
    /// Number of elements in the container
    public var count: Int {
        return delegate.count
    }
    
    /// Remove all elements in the container
    public mutating func removeAll() {
        delegate.removeAll()
    }
    
    // MARK: QueueType protocol
    
    /// Element at the back the queue. Assigning `nil` removes the back element.
    public var back: T? {
        get { return delegate.back }
        set { delegate.back = newValue }
    }
    
    /// Element at the front the queue. Assigning `nil` removes the front element.
    public var front: T? {
        get { return delegate.front }
        set { delegate.front = newValue }
    }
    
    /// Enqueue a new element at the tail
    public mutating func pushBack(item: T) {
        delegate.pushBack(item)
    }
    
    /// Dequeue an element from the head, returning it
    public mutating func popFront() -> T? {
        return delegate.popFront()
    }
    
    // MARK: DequeType protocol
    
    /// Insert a new element at the front
    public mutating func pushFront(item: T) {
        delegate.pushFront(item)
    }
    
    /// Dequeue an element from the tail, returning it
    public mutating func popBack() -> T? {
        return delegate.popBack()
    }
}


/**
    Make LinkedListDeque iterable.
*/
extension LinkedListDeque: MutableCollectionType {
    /// Always zero
    public var startIndex: Int {
        return delegate.startIndex
    }
    
    /// Equal to the number of elements in the arrpublic ay
    public var endIndex: Int {
        return delegate.endIndex
    }
    
    /// The position must be within bounds. Otherwise it might crash. Complexity: O(1)
    public subscript (position: Int) -> T {
        get {
            return delegate[position]
        }
        set {
            delegate[position] = newValue
        }
    }
    
    public func generate() -> LinkedListGenerator<T> {
        return delegate.generate()
    }
}
