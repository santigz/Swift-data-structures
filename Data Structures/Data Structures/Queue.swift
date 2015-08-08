//
//  Queue.swift
//
//  Created by Santiago González on 27/08/2014.
//  Copyright (c) 2014 Santiago González. All rights reserved.
//
// Notes for Swift beginners:
// - SequenceType protocol (formerly called Sequence) makes possible the use of for-in loop.
//   Read http://robots.thoughtbot.com/swift-sequences and http://schani.wordpress.com/2014/06/06/generators-in-swift/
//

import Foundation

/**
    Abstract container type with two ends: head and tail
 */
protocol DoubleEndedContainer {
    typealias ItemType
    
    var isEmpty: Bool { get }
    var count: Int { get }
    var head: ItemType? { get }
    var tail: ItemType? { get }

    mutating func purge()
}

/**
    Container that inserts and removes elements in LIFO (last-in first-out) order
 */
protocol Queue: DoubleEndedContainer {
    mutating func enqueueTail(item: ItemType)
    mutating func dequeueHead() -> ItemType?
}

/**
    Container that inserts and removes elements in FIFO (first-in first-out) order
 */
protocol Stack: DoubleEndedContainer {
    mutating func enqueueTail(item: ItemType)
    mutating func dequeueTail() -> ItemType?
}

/**
    ArrayQueue implements a circular queue using an array as a container.
    It must be created with a fixed capacity that can never exceed - otherwise it crashes.
 */
class CircularArray<T>: Queue, Stack {

    // Private attributes (waiting for Swift access modifiers)
    var array: [T?]
    var headIdx = 0
    var tailIdx = 0
    var count = 0

    // Public attributes

    /// The capacity of the ArrayQueue that can never be exceeded when enqueueing.
    let capacity: Int
    
    // MARK: ArrayQueue unique methods
    
    /// Init the array queue with a fixed capacity
    init(capacity: Int) {
        self.array = Array<T?>(count: capacity, repeatedValue: nil)
        self.capacity = capacity
    }
    
    /// Whether the array queue reached its maximum capacity
    var isFull: Bool {
        return count == array.count
    }
    
    // MARK: Queue protocol methods
    
    var isEmpty: Bool {
        return count == 0
    }
    
    var head: T? {
        return array[headIdx]
    }
    
    var tail: T? {
        return array[tailIdx]
    }
    
    func enqueueTail(item: T) {
        if isFull {
            assertionFailure("ArrayQueue too small")
            return
        }
        // The first element enqueued must match for head and tail
        if !isEmpty && ++tailIdx == array.count {
            tailIdx = 0
        }
        ++count
        array[tailIdx] = item
    }
    
    func dequeueHead() -> T? {
        if isEmpty {
            return nil
        }
        var result = array[headIdx]
        array[headIdx] = nil
        --count
        // The last element enqueued must match for head and tail
        if !isEmpty && ++headIdx == array.count {
            headIdx = 0
        }
        return result
    }
    
    func enqueueHead(item: T) {
        if isFull {
            assertionFailure("ArrayQueue too small")
            return
        }
        // The first element enqueued must match for head and tail
        if !isEmpty && --headIdx < 0 {
            headIdx = array.count - 1
        }
        ++count
        array[headIdx] = item
    }
    
    func dequeueTail() -> T? {
        if isEmpty {
            return nil
        }
        var result = array[tailIdx]
        array[tailIdx] = nil
        --count
        // The last element enqueued must match for head and tail
        if !isEmpty && --tailIdx < 0 {
            tailIdx = array.count - 1
        }
        return result
    }
    
    func purge() {
        array = Array<T?>(count: capacity, repeatedValue: nil)
        headIdx = 0
        tailIdx = 0
        count = 0
    }
}
