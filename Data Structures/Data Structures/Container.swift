//
//  Container.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Foundation

/**
    Abstract container type with two ends: head and tail
*/
protocol Container {
    typealias Element
    
    /// Whether the container is empty
    var isEmpty: Bool { get }
    
    /// Number of elements in the container
    var count: Int { get }
    
    /// Remove all elements in the container
    mutating func purge()
}

/**
    Double ended container that can insert and remove elements at both ends (front and back).
*/
protocol DoubleEndedContainer: Container {
    /// Element at the back of the container
    var back: Element? { get set }
    
    /// Element at the front of the container
    var front: Element? { get set }
    
    /// Insert a new element at the front
    mutating func pushFront(item: Element)
    
    /// Insert a new element at the back
    mutating func pushBack(item: Element)
    
    /// Remove an element from the front and return it if there is one
    mutating func popFront() -> Element?
    
    /// Remove an element from the back and return it if there is one
    mutating func popBack() -> Element?
}
