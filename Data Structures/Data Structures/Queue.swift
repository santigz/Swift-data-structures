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
    Container that inserts and removes elements in LIFO (last-in first-out) order.
    New elements are added at the tail and removed from the head.
 */
protocol Queue: Container {
    /// Element at the back the container
    var back: Element? { get }
    
    /// Element at the front the container
    var front: Element? { get }
    
    /// Enqueue a new element at the tail
    mutating func pushBack(item: Element)
    
    /// Dequeue an element from the head, returning it
    mutating func popFront() -> Element?
}

protocol Deque: Queue {
    /// Insert a new element at the front
    mutating func pushFront(item: Element)
    
    /// Dequeue an element from the tail, returning it
    mutating func popBack() -> Element?
}
