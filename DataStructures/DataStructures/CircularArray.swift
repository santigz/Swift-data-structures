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
    
    
    /// Init the array queue with a fixed capacity
    public init(capacity: Int) {
        self.array = Array<T?>(count: capacity, repeatedValue: nil)
        self.capacity = capacity
    }
    
    /// Init from a given Array<T>
    /// - Complexity: O(n)
    public init(array: [T]) {
        self.array = array.map { (let n) -> T? in return n } // Convert elements from T to T?
        self.capacity = array.count
        self.count = array.count
        self.backIdx = 0
        self.frontIdx = array.count - 1
    }
    
    /// Init from a given Array<T?>
    /// - Complexity: O(1)
    public init(array: [T?]) {
        self.array = array
        self.capacity = array.count
        self.count = array.count
        self.backIdx = 0
        self.frontIdx = array.count - 1
    }
    
    // MARK: DoubleEndedContainer protocol
    
    /// Whether the array queue reached its maximum capacity
    public var isFull: Bool {
        return count == array.count
    }
    
    /// Whether the circular array is empty
    public var isEmpty: Bool {
        return count == 0
    }
    
    /// Element at the back of the circular array. Assigning `nil` removes the back element.
    public var back: T? {
        get {
            return array[backIdx]
        }
        set {
            if array[backIdx] != nil {
                if let value = newValue {
                    // Replace the element
                    array[backIdx] = value
                } else {
                    // Remove the element
                    popBack()
                }
            } else if let value = newValue {
                // Insert the element
                pushBack(value)
            }
        }
    }
    
    /// Element at the front of the circular array. Assigning `nil` removes the front element.
    public var front: T? {
        get {
            return array[frontIdx]
        }
        set {
            if array[frontIdx] != nil {
                if let value = newValue {
                    // Replace the element
                    array[frontIdx] = value
                } else {
                    // Remove the element
                    popFront()
                }
            } else if let value = newValue {
                // Insert the element
                pushFront(value)
            }
        }
    }
    
    /// Insert a new element at the back
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
    
    /// Insert a new element at the front
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
    
    /// Remove an element from the back and return it if there is one
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
    
    /// Remove an element from the front and return it if there is one
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

extension CircularArray: ArrayLiteralConvertible {
    /// Initiate from an array
    public init(arrayLiteral elements: T...) {
        self.array = elements.map { (let n) -> T? in return n }
        self.capacity = elements.count
        self.count = elements.count
        self.backIdx = 0
        self.frontIdx = elements.count - 1
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
            let i = (position + frontIdx) % array.count
            return array[i]!
        }
        set {
            let i = (position + frontIdx) % array.count
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
