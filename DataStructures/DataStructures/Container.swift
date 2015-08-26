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
public protocol DoubleEndedContainer: Container, QueueType, DequeType {}
