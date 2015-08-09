//
//  LinkedList.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Foundation

/// Should be only visible inside LinkedList
class LinkedListElement<T> {
    let value: T?
    var back: LinkedListElement<T>? = nil
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

extension LinkedListElement: Printable, DebugPrintable {
    var description: String {
        return "LinkedListElement: \(value)"
    }
    var debugDescription: String {
        return "LinkedListElement: \(value)"
    }
}

/**
    LinkedList implementation. 
*/
public class LinkedList<T>: DoubleEndedContainer {
    typealias Element = T
    
    private var linkedFront: LinkedListElement<T>? = nil
    private var linkedBack: LinkedListElement<T>? = nil
    
    var count = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    var back: T? {
        get {
            return linkedBack?.value
        }
        set {
            if var back = linkedBack?.value {
                back = newValue!
            }
        }
    }
    
    var front: T? {
        get {
            return linkedFront?.value
        }
        set {
            if var front = linkedFront?.value {
                front = newValue!
            }
        }
    }

    /// Insert a new element to the back. Complexity: O(1)
    func pushBack(item: T) {
        let newBack = LinkedListElement<T>(value: item, back: nil, front: linkedBack)
        if linkedFront == nil {
            linkedFront = newBack
        }
        linkedBack?.back = newBack
        linkedBack = newBack
        ++count
    }
    
    /// Insert a new element to the front. Complexity: O(1)
    func pushFront(item: T) {
        let newTail = LinkedListElement<T>(value: item, back: linkedFront, front: nil)
        if linkedBack == nil {
            linkedBack = newTail
        }
        linkedFront?.front = newTail
        linkedFront = newTail
        ++count
    }
    
    /// Remove the element at the back if any and return it. Complexity: O(1)
    func popBack() -> T? {
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
    func popFront() -> T? {
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
    
    func removeAll() {
        // All is removed in cascade because LinkedListElement.front is weak
        linkedFront = nil
        linkedBack = nil
        count = 0
    }
}

extension LinkedList: Printable, DebugPrintable {
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

/**
    Queue, Deque and Stack methods are fully included in DoubleEndedContainer protocol, so there's no need to add anything other method. This extension exists to enable polymorphism.
*/
extension LinkedList: Queue, Deque, Stack {
}
