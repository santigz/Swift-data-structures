//
//  QueueTests.swift
//  DataStructures
//
//  Created by Santiago González on 26/08/2015.
//  Copyright © 2015 sangonz. All rights reserved.
//

import XCTest


/// Test a queue that should be empty
func testEmptyQueue<T: QueueType where T.Generator.Element == Int>(var queue: T) {
    testEmptyContainer(queue)
    XCTAssertNil(queue.back)
    XCTAssertNil(queue.front)
    XCTAssertNil(queue.popFront())
}

/// Test a filled queue
func testFilledQueue<T: QueueType where T.Generator.Element == Int>(var queue: T) {
    XCTAssertFalse(queue.isEmpty)
    XCTAssertNotNil(queue.back)
    XCTAssertNotNil(queue.front)
    
    // Test popFront()
    XCTAssertEqual(queue.front, queue.popFront())
}

/// `pushBack()` in a container to insert the data: (front) 1...testLength (back)
func testPushBack<T: QueueType where T.Generator.Element == Int>(inout queue: T) {
    testEmptyQueue(queue)
    for element in 1...testLength {
        queue.pushBack(element)
        XCTAssertEqual(queue.count, element, "Container should have \(element) elements")
        XCTAssertNotNil(queue.isEmpty, "Container should not be empty")
        XCTAssertEqual(queue.back, element, "Bad back")
        XCTAssertEqual(queue.front, 1, "Bad front")
    }
    XCTAssertEqual(queue.count, testLength)
    testFilledQueue(queue)
}

/// `popFront()` from a queue with the data: (front) 1...testLength (back)
func testPopFront<T: QueueType where T.Generator.Element == Int>(inout queue: T) {
    testFilledQueue(queue)
    for element in 1...(testLength - 1) {
        let popped = queue.popFront()
        XCTAssertEqual(popped, element, "Bad popFront() element")
        let revelement = testLength - element
        XCTAssertEqual(queue.count, revelement, "Container should have \(revelement) elements")
        XCTAssertNotNil(queue.isEmpty, "Container should not be empty")
        XCTAssertEqual(queue.back, testLength, "Bad back")
        XCTAssertEqual(queue.front, element + 1, "Bad front")
    }
    XCTAssertEqual(queue.popFront(), testLength, "Bad popFront() element")
    XCTAssertNil(queue.popFront())
    testEmptyQueue(queue)
}

func testQueue<T: QueueType where T.Generator.Element == Int>(var queue: T) {
    XCTAssert(queue.isEmpty, "This test requires an empty container")
    
    // Test push, pop and subscript
    testEmptyQueue(queue)
    testPushBack(&queue)
    testFilledQueue(queue)
    testSubscript(queue)
    testPopFront(&queue)
    testEmptyQueue(queue)
    
    // Test removeAll
    testRemoveAll(&queue)
    testPushBack(&queue)
    testRemoveAll(&queue)
    testEmptyQueue(queue)
}

class QueueTests: XCTestCase {
    
    func testCircularArrayQueue() {
        let queue = CircularArrayQueue<Int>(capacity: testLength)
        testQueue(queue)
    }

    func testLinkedListQueue() {
        let queue = LinkedListQueue<Int>()
        testQueue(queue)
    }
    
}
