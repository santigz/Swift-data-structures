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
    
    func pushFront(item: T) {
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
    
    func popBack() -> T? {
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
    
    func popFront() -> T? {
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
    func removeAll() {
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
    var startIndex: Int {
        return 0;
    }
    
    /// Equal to the number of elements in the array
    var endIndex: Int {
        return count
    }
    
    /// The position must be within bounds. Otherwise it might crash. Complexity: O(1)
    subscript (position: Int) -> T {
        get {
            let i = (position + frontIdx) % count
            return array[i]!
        }
        set {
            let i = (position + frontIdx) % count
            array[i] = newValue
        }
    }
    
    func generate() -> CircularArrayGenerator<T> {
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
struct CircularArrayGenerator<T>: GeneratorType {
    /// Array with the sub-arrays as slices of the elements. Everything must be in reverse order for efficiency
    var slices: Array<ArraySlice<T?>>
    mutating func next() -> T? {
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
extension CircularArray: Container, Queue, Deque, Stack {}

//extension CircularArray: Equatable {}
//func ==<T> (lhs: CircularArray<T>, rhs: CircularArray<T>) -> Bool {
//    // We can't compare `lhs.array == rhs.array` because the array has optional values. Looks like a Swift bug.
//    return lhs.array == rhs.array
//}

