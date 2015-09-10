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
        let llist = LinkedList<Int>()
        testDeque(llist, length: 100)
    }
    
    func testBack() {
        var llist = LinkedList<Int>()
        
        testPushFrontOnEnds(llist)
        
        testEmptyDequeBack(llist)
        testEmptyDequeFront(llist)
        testPushBack(&llist, length: 100)
        testFilledDeque(llist)
        testFilledDequeBack(llist)
        testFilledDequeFront(llist)
    }
    
    /// Test the (de)initialization of elements for class elements
    func testClassElements() {
        let length = 100
        var llist = LinkedList<ClassElement>()
        ClassElement.nInit = 0
        ClassElement.nDeinit = 0
        for _ in 1...length {
            llist.pushBack(ClassElement())
        }
        llist.removeAll()
        XCTAssertEqual(ClassElement.nInit, length, "Wrong number of initializations")
        XCTAssertEqual(ClassElement.nDeinit, length, "Wrong number of deinitializations")
    }
    
    /// Test the initialization of elements for struct elements
    func testStructElements() {
        let length = 100
        var llist = LinkedList<StructElement>()
        StructElement.nInit = 0
        for _ in 1...length {
            llist.pushBack(StructElement())
        }
        llist.removeAll()
        XCTAssertEqual(StructElement.nInit, length, "Wrong number of initializations")
    }
    
    func testLinkedListPerformance() {
        self.measureBlock() {
            let length = 100
            var llist = LinkedList<Int>()
            for _ in 1...length {
                llist.pushFront(1)
            }
            for _ in 1...length {
                llist.popBack()
            }
        }
    }

}
