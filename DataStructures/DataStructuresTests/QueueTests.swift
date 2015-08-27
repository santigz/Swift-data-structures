//
//  QueueTests.swift
//  DataStructures
//
//  Created by Santiago González on 26/08/2015.
//  Copyright © 2015 sangonz. All rights reserved.
//

import XCTest

func testEmptyContainer<T: Container where T.Generator.Element == Int>(inout container: T) {
    XCTAssertTrue(container.isEmpty)
    XCTAssertEqual(container.count, 0)
}

func testEmptyDeque<T: DequeType where T.Generator.Element == Int>(inout container: T) {
    testEmptyQueue(&container)
    XCTAssertNil(container.popBack())
}

func testEmptyQueue<T: QueueType where T.Generator.Element == Int>(inout container: T) {
    testEmptyContainer(&container)
    XCTAssertNil(container.back)
    XCTAssertNil(container.front)
    XCTAssertNil(container.popFront())
    
    // Test nil assignment on empty container
    container.back = nil
    container.front = nil
    XCTAssertNil(container.back)
    XCTAssertNil(container.front)
}

func testFullContainer<T: Container where T.Generator.Element == Int>(container: T) {
    XCTAssertFalse(container.isEmpty)
    XCTAssertEqual(container.count, testLength)
}

func testFullDeque<T: DequeType where T.Generator.Element == Int>(var container: T) {
    testFullContainer(container)
    testFullQueue(container)
    
    let back = container.back!
    let front = container.front!
    
    // Test popBack()
    let popBack = container.popBack()
    XCTAssertNotNil(popBack)
    XCTAssertEqual(popBack, back)
    container.pushBack(popBack!)
}

func testFullQueue<T: QueueType where T.Generator.Element == Int>(var container: T) {
    testFullContainer(container)
    
    
    XCTAssertNotNil(container.back)
    XCTAssertNotNil(container.front)
    
    let back = container.back!
    let front = container.front!
    
    // Test popFront()
    let popFront = container.popFront()
    XCTAssertNotNil(popFront)
    XCTAssertEqual(popFront, front)
    
    // Test different types of assignments on back and front
    let testVal = testLength * 2
    
    container.back = nil
    XCTAssertEqual(container.count, testLength - 1)
    container.pushBack(testVal)
    XCTAssertEqual(container.back, testVal)
    container.back = back
    XCTAssertEqual(container.back, back)
    XCTAssertEqual(container.count, testLength)
    
    container.front = nil
    XCTAssertEqual(container.count, testLength - 1)
    container.pushFront(testVal)
    XCTAssertEqual(container.front, testVal)
    container.front = front
    XCTAssertEqual(container.front, front)
    XCTAssertEqual(container.count, testLength)
}

func testQueuePushBack<T: QueueType where T.Generator.Element == Int>(inout container: T) {
    for element in 1...testLength {
        container.pushBack(element)
        XCTAssertEqual(container.count, element, "Container should have \(element) elements")
        XCTAssertNotNil(container.isEmpty, "Container should not be empty")
        XCTAssertEqual(container.back, element, "Bad back")
        XCTAssertEqual(container.front, 1, "Bad front")
    }
}

func testQueuePopFront<T: QueueType where T.Generator.Element == Int>(inout container: T) {
    
}

class QueueTests: XCTestCase {

    func queueTest<T: QueueType where T.Generator.Element == Int>(inout queue: T) {
        XCTAssert(queue.count == 0)
        XCTAssert(queue.isEmpty)
        
        XCTAssertNil(queue.front)
        XCTAssertNil(queue.back)
        XCTAssertNil(queue.popFront())
    }
    
    func testQueue() {
        var queue = CircularArrayQueue<Int>(capacity: 10)
        
        testDoubleEndedContainer(&queue)
        
    }

}
