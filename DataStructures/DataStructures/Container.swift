//
//  Container.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Foundation

/**
    Abstract container type with two ends: head and tail
*/
public protocol Container: MutableCollectionType {
    /// Whether the container is empty
    var isEmpty: Bool { get }
    
    /// Number of elements in the container
    var count: Int { get }
    
    /// Remove all elements in the container
    mutating func removeAll()

    // This is here to force the typealias Index to be Int
    subscript (index: Int) -> Self.Generator.Element { get set }
}

/**
    Double ended container that can insert and remove elements at both ends (front and back).
    The container is subscriptable from the front (index zero) to the back (largest index)
*/
public protocol DoubleEndedContainer: Container, QueueType {
    /// Element at the back of the container
    var back: Self.Generator.Element? { get set }
    
    /// Element at the front of the container
    var front: Self.Generator.Element? { get set }
    
    /// Insert a new element at the front
    mutating func pushFront(item: Self.Generator.Element)
    
    /// Insert a new element at the back
    mutating func pushBack(item: Self.Generator.Element)
    
    /// Remove an element from the front and return it if there is one
    mutating func popFront() -> Self.Generator.Element?
    
    /// Remove an element from the back and return it if there is one
    mutating func popBack() -> Self.Generator.Element?
}
