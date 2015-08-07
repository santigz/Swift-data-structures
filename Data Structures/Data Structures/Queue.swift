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

protocol Queue {
    typealias ItemType
    
    var isEmpty: Bool { get }
    var count: Int { get }
    var head: ItemType? { get }
    var tail: ItemType? { get }
    
    mutating func enqueueTail(item: ItemType)
    mutating func dequeueHead() -> ItemType?
}

protocol BidirectionalQueue: Queue {
    mutating func enqueueHead(item: ItemType)
    mutating func dequeueTail() -> ItemType?
}

class ArrayQueue<T>: BidirectionalQueue {
    lazy var array = Array<T?>(count: 512, repeatedValue: nil)
    var headIdx: Int = 0
    var tailIdx: Int = 0
    var count: Int = 0
    
    init(capacity: Int) {
        array = Array<T?>(count: capacity, repeatedValue: nil)
    }
    
    var isEmpty: Bool {
        return count == 0
    }
    
    var isFull: Bool {
        return count == array.count
    }
    
    var head: T? {
        return array[headIdx]
    }
    
    var tail: T? {
        return array[tailIdx]
    }
    
    // Queue methods
    
    func enqueueTail(item: T) {
        if isFull {
            assertionFailure("ArrayQueue too small")
            return
        }
        if ++tailIdx == array.count {
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
        if ++headIdx == array.count {
            headIdx = 0
        }
        --count
        return result
    }
    
    // BidirectionalQueue methods
    
    func enqueueHead(item: T) {
        if isFull {
            assertionFailure("ArrayQueue too small")
            return
        }
        if --headIdx < 0 {
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
        if --tailIdx < 0 {
            tailIdx = array.count - 1
        }
        --count
        return result
    }
}
