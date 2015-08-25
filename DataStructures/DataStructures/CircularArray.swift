//
//  CircularArray.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Foundation

// TODO: Make CircularArray dynamic.

/**
    ArrayQueue implements a circular queue using an array as a container.
    It can be used as Queue, Stack and BidirectionalContainer.
    It must be created with a fixed capacity that can never exceed - otherwise it crashes.

    - TODO: Make it dynamic so the size increases or decreases transparently.
*/
public struct CircularArray<T>: DoubleEndedContainer {
    private var array: [T?]
    private var backIdx = 0
    private var frontIdx = 0
    
    public private(set) var count = 0
    
    /// The capacity of the ArrayQueue that can never be exceeded when enqueueing.
    public let capacity: Int
    
    // MARK: ArrayQueue unique methods
    
    /// Init the array queue with a fixed capacity
    public init(capacity: Int) {
        self.array = Array<T?>(count: capacity, repeatedValue: nil)
        self.capacity = capacity
    }
    
    /// Whether the array queue reached its maximum capacity
    public var isFull: Bool {
        return count == array.count
    }
    
    // MARK: Other DoubleEndedContainer methods
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var back: T? {
        get {
            return array[backIdx]
        }
        set {
            array[backIdx] = newValue
        }
    }
    
    public var front: T? {
        get {
            return array[frontIdx]
        }
        set {
            array[frontIdx] = newValue
        }
    }
    
    public mutating func pushBack(item: T) {
        if isFull {
            assertionFailure("CircularArray too small")
            return
        }
        // The first element enqueued must match for back and front
        if !isEmpty && ++backIdx == array.count {
            backIdx = 0
        }
        ++count
        array[backIdx] = item
    }
    
    public mutating func pushFront(item: T) {
        if isFull {
            assertionFailure("CircularArray too small")
            return
        }
        // The first element enqueued must match for back and front
        if !isEmpty && --frontIdx < 0 {
            frontIdx = array.count - 1
        }
        ++count
        array[frontIdx] = item
    }
    
    public mutating func popBack() -> T? {
        if isEmpty {
            return nil
        }
        let result = array[backIdx]
        array[backIdx] = nil
        --count
        // The last element enqueued must match for back and front
        if !isEmpty && --backIdx < 0 {
            backIdx = array.count - 1
        }
        return result
    }
    
    public mutating func popFront() -> T? {
        if isEmpty {
            return nil
        }
        let result = array[frontIdx]
        array[frontIdx] = nil
        --count
        // The last element enqueued must match for back and front
        if !isEmpty && ++frontIdx == array.count {
            frontIdx = 0
        }
        return result
    }
    
    /// Remove all the elements of the circular array
    public mutating func removeAll() {
        array = Array<T?>(count: capacity, repeatedValue: nil)
        backIdx = 0
        frontIdx = 0
        count = 0
    }
}

/**
    Make the CircularArray iterable as a regular array, starting from frontIdx and looping through the array transparently
 */
extension CircularArray: MutableCollectionType {
    /// Always zero
    public var startIndex: Int {
        return 0
    }
    
    /// Equal to the number of elements in the arrpublic ay
    public var endIndex: Int {
        return count
    }
    
    /// The position must be within bounds. Otherwise it might crash. Complexity: O(public 1)
    public subscript (position: Int) -> T {
        get {
            let i = (position + frontIdx) % count
            return array[i]!
        }
        set {
            let i = (position + frontIdx) % count
            array[i] = newValue
        }
    }
    
    public func generate() -> CircularArrayGenerator<T> {
        var slices: Array<ArraySlice<T?>> = []
        if isEmpty {
            return CircularArrayGenerator(slices: slices)
        }
        if backIdx > frontIdx {
            slices.append(ArraySlice(array[frontIdx...backIdx].reverse()))
        } else {
            slices.append(ArraySlice(array[0...backIdx].reverse()))
            slices.append(ArraySlice(array[frontIdx..<capacity].reverse()))
        }
        return CircularArrayGenerator(slices: slices)
    }
}


/**
This class is used to make CircularArray subscriptable.
*/
public struct CircularArrayGenerator<T>: GeneratorType {
    /// Array with the sub-arrays as slices of the elements. Everything must be in reverse order for efficiency
    private var slices: Array<ArraySlice<T?>>
    
    public mutating func next() -> T? {
        if slices.isEmpty {
            return nil
        }
        let ret = slices[slices.count - 1].removeLast()
        if slices[slices.count - 1].isEmpty {
            slices.removeLast()
        }
        return ret
    }
}

extension CircularArray: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return "CircularArray: " + array.description
    }
    public var debugDescription: String {
        return "CircularArray: " + array.debugDescription
    }
}
