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

/// `pushBack()` in a container to insert the data: (front) 1...length (back)
func testPushBack<T: QueueType where T.Generator.Element == Int>(inout queue: T, length: Int) {
    testEmptyQueue(queue)
    for element in 1...length {
        queue.pushBack(element)
        XCTAssertEqual(queue.count, element, "Container should have \(element) elements")
        XCTAssertNotNil(queue.isEmpty, "Container should not be empty")
        XCTAssertEqual(queue.back, element, "Bad back")
        XCTAssertEqual(queue.front, 1, "Bad front")
    }
    XCTAssertEqual(queue.count, length)
    testFilledQueue(queue)
}

/// `popFront()` from a queue with the data: (front) 1...queue.count (back)
func testPopFront<T: QueueType where T.Generator.Element == Int>(inout queue: T) {
    testFilledQueue(queue)
    let count = queue.count
    for element in 1...(count - 1) {
        let popped = queue.popFront()
        XCTAssertEqual(popped, element, "Bad popFront() element")
        let revelement = count - element
        XCTAssertEqual(queue.count, revelement, "Container should have \(revelement) elements")
        XCTAssertNotNil(queue.isEmpty, "Container should not be empty")
        XCTAssertEqual(queue.back, count, "Bad back")
        XCTAssertEqual(queue.front, element + 1, "Bad front")
    }
    XCTAssertEqual(queue.popFront(), count, "Bad popFront() element")
    XCTAssertNil(queue.popFront())
    testEmptyQueue(queue)
}

func testQueue<T: QueueType where T.Generator.Element == Int>(var queue: T, length: Int) {
    XCTAssert(queue.isEmpty, "This test requires an empty container")
    
    // Test push, pop and subscript
    testEmptyQueue(queue)
    testPushBack(&queue, length: length)
    testFilledQueue(queue)
    testSubscript(queue)
    testPopFront(&queue)
    testEmptyQueue(queue)
    
    // Test removeAll on empty and filled queue
    testRemoveAll(&queue)
    testPushBack(&queue, length: length)
    testRemoveAll(&queue)
    testEmptyQueue(queue)
}

class QueueTests: XCTestCase {
    
    func testCircularArrayQueue() {
        let queue = CircularArrayQueue<Int>(capacity: 100)
        testQueue(queue, length: 100)
    }

    func testLinkedListQueue() {
        let queue = LinkedListQueue<Int>()
        testQueue(queue, length: 100)
    }
    
}
