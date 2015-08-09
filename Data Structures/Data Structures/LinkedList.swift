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
    
    func purge() {
        // Since LinkedListElement.back is weak, deleting our links will delete all the elements in cascade
        linkedFront = nil
        linkedBack = nil
        count = 0
    }
}

/**
    Queue, Deque and Stack methods are fully included in DoubleEndedContainer protocol, so there's no need to add anything other method.
 */
extension LinkedList: Queue, Deque, Stack {
}
