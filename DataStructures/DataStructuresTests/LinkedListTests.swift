//
//  LinkedListTests.swift
//  DataStructures
//
//  Created by Santiago González on 26/08/2015.
//  Copyright © 2015 sangonz. All rights reserved.
//

import XCTest


protocol Initiable {
    init()
}

final class ClassElement: Initiable {
    static var nInit = 0
    static var nDeinit = 0
    init() {
        ++ClassElement.nInit
    }
    deinit {
        ++ClassElement.nDeinit
    }
}

struct StructElement: Initiable {
    static var nInit = 0
    init() {
        ++StructElement.nInit
    }
}

class LinkedListTests: XCTestCase {
    
    func testLinkedList() {
        var llist = LinkedList<Int>()
        testDoubleEndedContainer(&llist)
    }
    
    func testBack() {
        var llist = LinkedList<Int>()
        
        testPushFrontOnEnds(llist)
        
        testEmptyDequeBack(llist)
        testEmptyDequeFront(llist)
        testPushBack(&llist)
        testFilledDeque(llist)
        testFilledDequeBack(llist)
        testFilledDequeFront(llist)
    }
    
    func removeAllTest<T: Initiable>(_: T) {
        // Test that all objects are deinitialized on removeAll()
        // We only have the input argument to know the type of elements to push
        var llist = LinkedList<T>()
        ClassElement.nInit = 0
        ClassElement.nDeinit = 0
        for _ in 1...testLength {
            llist.pushBack(T())
        }
        
        llist.removeAll()
        XCTAssertEqual(ClassElement.nInit, testLength, "Wrong number of initializations")
        XCTAssertEqual(ClassElement.nDeinit, testLength, "Wrong number of deinitializations")
    }
    
    func testRemoveAll() {
        
        removeAllTest(ClassElement())
        
    }
    
    func testLinkedListPerformance() {
        self.measureBlock() {
            var llist = LinkedList<Int>()
            for _ in 1...testLength {
                llist.pushFront(1)
            }
            for _ in 1...testLength {
                llist.popBack()
            }
        }
    }

}
