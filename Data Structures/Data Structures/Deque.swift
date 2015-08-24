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
protocol DequeType: QueueType {
    /// Insert a new element at the front
    mutating func pushFront(item: Self.Generator.Element)
    
    /// Dequeue an element from the tail, returning it
    mutating func popBack() -> Self.Generator.Element?
}


/**
    The default implementation of a Deque is a linked list. You can change the default behaviour by changing the superclass to `CircularArrayDeque`.
*/
class Deque<T>: LinkedListDeque<T> {}


/**
    Implementation of a deque as a circular array. The whole implementation is delegated to `CircularArray`.
*/
class CircularArrayDeque<T>: CircularArrayQueue<T>, DequeType {

    /// Insert a new element at the front
    func pushFront(item: T) {
        delegate.pushFront(item)
    }
    
    /// Dequeue an element from the tail, returning it
    func popBack() -> T? {
        return delegate.popBack()
    }
}


/**
    Implementation of a deque as a linked list. The whole implementation is delegated to `LinkedList`.
*/
class LinkedListDeque<T>: LinkedListQueue<T>, DequeType {
    
    /// Insert a new element at the front
    func pushFront(item: T) {
        delegate.pushFront(item)
    }
    
    /// Dequeue an element from the tail, returning it
    func popBack() -> T? {
        return delegate.popBack()
    }
}
