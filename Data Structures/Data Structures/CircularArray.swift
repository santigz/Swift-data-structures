//
//  CircularArray.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Foundation


/**
    ArrayQueue implements a circular queue using an array as a container.
    It can be used as Queue, Stack and BidirectionalContainer.
    It must be created with a fixed capacity that can never exceed - otherwise it crashes.
*/
class CircularArray<T>: DoubleEndedContainer {
    typealias Element = T
    
    private var array: [T?]
    private var backIdx = 0
    private var frontIdx = 0
    
    var count = 0
    
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
    
    // MARK: Other BidirectionalContainer methods
    
    var isEmpty: Bool {
        return count == 0
    }
    
    var back: T? {
        get {
            return array[backIdx]
        }
        set {
            array[backIdx] = newValue
        }
    }
    
    var front: T? {
        get {
            return array[frontIdx]
        }
        set {
            array[frontIdx] = newValue
        }
    }
    
    func pushBack(item: T) {
        if isFull {
            assertionFailure("ArrayQueue too small")
            return
        }
        // The first element enqueued must match for back and front
        if !isEmpty && ++backIdx == array.count {
            backIdx = 0
        }
        ++count
        array[backIdx] = item
    }
    
    func pushFront(item: T) {
        if isFull {
            assertionFailure("ArrayQueue too small")
            return
        }
        // The first element enqueued must match for back and front
        if !isEmpty && --frontIdx < 0 {
            frontIdx = array.count - 1
        }
        ++count
        array[frontIdx] = item
    }
    
    func popBack() -> T? {
        if isEmpty {
            return nil
        }
        var result = array[backIdx]
        array[backIdx] = nil
        --count
        // The last element enqueued must match for back and front
        if !isEmpty && --backIdx < 0 {
            backIdx = array.count - 1
        }
        return result
    }
    
    func popFront() -> T? {
        if isEmpty {
            return nil
        }
        var result = array[frontIdx]
        array[frontIdx] = nil
        --count
        // The last element enqueued must match for back and front
        if !isEmpty && ++frontIdx == array.count {
            frontIdx = 0
        }
        return result
    }
    
    func removeAll() {
        array = Array<T?>(count: capacity, repeatedValue: nil)
        backIdx = 0
        frontIdx = 0
        count = 0
    }
}

extension CircularArray: Printable, DebugPrintable {
    var description: String {
        return "CircularArray: " + array.description
    }
    var debugDescription: String {
        return "CircularArray: " + array.debugDescription
    }
}

/**
    Queue, Deque and Stack methods are fully included in DoubleEndedContainer protocol, so there's no need to add anything other method. This extension exists to enable polymorphism.
*/
extension CircularArray: Queue, Deque, Stack {
}

