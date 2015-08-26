//
//  LinkedListTests.swift
//  DataStructures
//
//  Created by Santiago González on 26/08/2015.
//  Copyright © 2015 sangonz. All rights reserved.
//

import XCTest

class LinkedListTests: XCTestCase {
    
    class TestElement {
        deinit {
            ++nElementsDeinitialized
        }
    }
    
    func testLinkedList() {
        var llist = LinkedList<Int>()
        testDoubleEndedContainer(&llist)
        
        // Test that all objects are deinitialized on removeAll()
        var llist2 = LinkedList<TestElement>()
        nElementsDeinitialized = 0
        for _ in 1...testLength {
            llist2.pushBack(TestElement())
        }
        
        llist2.removeAll()
        XCTAssert(nElementsDeinitialized == testLength, "Wrong number of deinitializers")
    }
    
    func testLinkedListPerformance() {
        self.measureBlock() {
            let length = 1000
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
