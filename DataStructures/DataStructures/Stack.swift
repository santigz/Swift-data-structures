//
//  Stack.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Foundation


/**
    Container that inserts and removes elements in FIFO (first-in first-out) order.
    Elements are inserted to and removed from the same end, the back.
    Subscripting and looping go from front to back.
*/
protocol Stack: Container {
    typealias Element
    
    // Last added element to the stack
    var back: Element? { get set }
    
    // First added element to the stack
    var front: Element? { get set }
    
    /// Insert a new element to the back
    mutating func pushBack(item: Element)
    
    /// Remove an element from the back, returning it
    mutating func popBack() -> Element?
}
