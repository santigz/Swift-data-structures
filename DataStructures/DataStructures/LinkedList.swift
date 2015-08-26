//
//  LinkedList.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Foundation

/**
    Should be only visible inside LinkedList.
 */
class LinkedListElement<T> {
    var value: T
    var back: LinkedListElement<T>? = nil
    
    // front is weak to avoid reference cycles
    weak var front: LinkedListElement<T>? = nil
    
    init(value: T) {
        self.value = value
    }
    
    init(value: T, back: LinkedListElement?, front: LinkedListElement?) {
        self.value = value
        self.back = back
        self.front = front
    }
}

extension LinkedListElement: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        // TODO: How can we call `value.description` when possible?
        return "LinkedListElement: \(value)"
    }
    var debugDescription: String {
        return "LinkedListElement: \(value)"
    }
}

/**
    LinkedList implementation. 
*/
public struct LinkedList<T>: DoubleEndedContainer {
    private var linkedFront: LinkedListElement<T>? = nil
    private var linkedBack: LinkedListElement<T>? = nil
    
    public private(set) var count = 0
    
    /// Whether the linked list is empty
    public var isEmpty: Bool {
        return count == 0
    }
    
    /// Element at the back of the linked list. Assigning `nil` removes the back element.
    public var back: T? {
        get {
            return linkedBack?.value
        }
        set {
            if let lback = linkedBack {
                if let value = newValue {
                    // Replace the element
                    lback.value = value
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
    
    /// Element at the front of the linked list. Assigning `nil` removes the front element.
    public var front: T? {
        get {
            return linkedFront?.value
        }
        set {
            if let lfront = linkedFront {
                if let value = newValue {
                    // Replace the element
                    lfront.value = value
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

    /// Insert a new element to the back
    /// - Complexity: O(1)
    public mutating func pushBack(item: T) {
        let newBack = LinkedListElement<T>(value: item, back: nil, front: linkedBack)
        if linkedFront == nil {
            linkedFront = newBack
        }
        linkedBack?.back = newBack
        linkedBack = newBack
        ++count
    }
    
    /// Insert a new element to the front. Complexity: O(1)
    public mutating func pushFront(item: T) {
        let newTail = LinkedListElement<T>(value: item, back: linkedFront, front: nil)
        if linkedBack == nil {
            linkedBack = newTail
        }
        linkedFront?.front = newTail
        linkedFront = newTail
        ++count
    }
    
    /// Remove the element at the back if any and return it. Complexity: O(1)
    public mutating func popBack() -> T? {
        if isEmpty {
            return nil
        }
        --count
        let result = linkedBack!
        linkedBack!.front?.back = nil
        linkedBack = result.front
        if count == 0 {
            linkedFront = nil
        }
        return result.value
    }
    
    /// Remove the element at the front if any and return it. Complexity: O(1)
    public mutating func popFront() -> T? {
        if isEmpty {
            return nil
        }
        --count
        let result = linkedFront!
        linkedFront!.back?.front = nil
        linkedFront = result.back
        if count == 0 {
            linkedBack = nil
        }
        return result.value
    }
    
    /// Remove all the elements of the linked list
    public mutating func removeAll() {
        // All is removed in cascade because LinkedListElement.front is weak
        linkedFront = nil
        linkedBack = nil
        count = 0
    }
}

/**
Make the CircularArray iterable as a regular array, starting from frontIdx and looping through the array transparently
*/
extension LinkedList: MutableCollectionType {
    /// Always zero
    public var startIndex: Int {
        return 0;
    }
    
    /// Equal to the number of elements in the array
    public var endIndex: Int {
        return count
    }
    
    /// Returns the LinkedListElement at the given position
    private func element(position: Int) -> LinkedListElement<T> {
        var element = linkedFront!
        for _ in 0..<position {
            element = element.back!
        }
        return element
    }
    
    /// The position must be within bounds. Otherwise it might crash. Complexity: O(n)
    public subscript (position: Int) -> T {
        get {
            return element(position).value
        }
        set {
            element(position).value = newValue
        }
    }
    
    /// Function for iterating the linked list
    public func generate() -> LinkedListGenerator<T> {
        return LinkedListGenerator(frontElement: linkedFront)
    }
}

/**
    This class is used to make LinkedList subscriptable
*/
public struct LinkedListGenerator<T>: GeneratorType {
    private var frontElement: LinkedListElement<T>?
    mutating public func next() -> T? {
        if frontElement == nil {
            return nil
        }
        let ret = frontElement!.value
        frontElement = frontElement!.back
        return ret
    }
}

extension LinkedList: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        var desc = "LinkedList = \(self.count) items {"
        var element = linkedFront
        while element != nil {
            desc += "    " + element!.description
            element = element!.back
        }
        desc += "}"
        return desc
    }
    public var debugDescription: String {
        var desc = "LinkedList = \(self.count) items {"
        var element = linkedFront
        while element != nil {
            desc += "    " + element!.debugDescription
            element = element!.back
        }
        desc += "}"
        return desc
    }
}

