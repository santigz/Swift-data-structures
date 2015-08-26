//
//  Data_StructuresTests.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Cocoa
import XCTest

var nElementsDeinitialized = 0

// Size of the arrays for testing
let testLength = 100



func testDECEmpty<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    XCTAssertTrue(container.isEmpty)
    XCTAssertEqual(container.count, 0)
    XCTAssertNil(container.back)
    XCTAssertNil(container.front)
    XCTAssertNil(container.popBack())
    XCTAssertNil(container.popFront())
    
    // Test nil assignment on empty container
    container.back = nil
    container.front = nil
    XCTAssertNil(container.back)
    XCTAssertNil(container.front)
}

func testDECFull<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    XCTAssertFalse(container.isEmpty)
    XCTAssertEqual(container.count, testLength)
    XCTAssertNotNil(container.back)
    XCTAssertNotNil(container.front)
    
    let back = container.back!
    let front = container.front!
    
    // Test popBack()
    let popBack = container.popBack()
    XCTAssertNotNil(popBack)
    XCTAssertEqual(popBack, back)
    container.pushBack(popBack!)
    
    // Test popFront()
    let popFront = container.popFront()
    XCTAssertNotNil(popFront)
    XCTAssertEqual(popFront, front)
    container.pushFront(popFront!)
    
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

/**
pushBack in a container to insert the data: (front) 1...testLength (back)
*/
func testDECPushBack<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    
    testDECEmpty(&container)
    
    for element in 1...testLength {
        container.pushBack(element)
        XCTAssertEqual(container.count, element, "Container should have \(element) elements")
        XCTAssertNotNil(container.isEmpty, "Container should not be empty")
        XCTAssertEqual(container.back, element, "Bad back")
        XCTAssertEqual(container.front, 1, "Bad front")
    }
    
    testDECFull(&container)
}


/**
pushFront in a container to insert the data: (front) 1...testLength (back)
*/
func testDECPushFront<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    
    testDECEmpty(&container)
    
    for element in Array((1...testLength).reverse()) {
        container.pushFront(element)
        let count = testLength - element + 1
        XCTAssertEqual(container.count, count, "Container should have \(count) elements")
        XCTAssertNotNil(container.isEmpty, "Container should not be empty")
        XCTAssertEqual(container.back, testLength, "Bad back")
        XCTAssertEqual(container.front, element, "Bad front")
    }
    
    testDECFull(&container)
}

/**
popBack from a container with the data: (front) 1...testLength (back)
*/
func testDECPopBack<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    
    testDECFull(&container)
    
    for element in Array((2...testLength).reverse()) {
        let popped = container.popBack()
        XCTAssertEqual(popped!, element, "Bad popFront() element")
        XCTAssertEqual(container.count, element - 1, "Container should have \(element) elements")
        XCTAssertNotNil(container.isEmpty, "Container should not be empty")
        XCTAssertEqual(container.back, element - 1, "Bad back")
        XCTAssertEqual(container.front, 1, "Bad front")
    }
    XCTAssertEqual(container.popBack(), 1, "Bad popFront() element")
    testDECEmpty(&container)
}

/**
popFront from a container with the data: (front) 1...testLength (back)
*/
func testDECPopFront<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    
    testDECFull(&container)
    
    for element in 1...(testLength - 1) {
        let popped = container.popFront()
        XCTAssert(popped! == element, "Bad popFront() element")
        let revelement = testLength - element
        XCTAssertEqual(container.count, revelement, "Container should have \(revelement) elements")
        XCTAssertNotNil(container.isEmpty, "Container should not be empty")
        XCTAssertEqual(container.back, testLength, "Bad back")
        XCTAssertEqual(container.front, element + 1, "Bad front")
    }
    XCTAssertEqual(container.popFront(), testLength, "Bad popFront() element")
    testDECEmpty(&container)
}

func testDECSubscript<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    for element in 1...testLength {
        container.pushBack(element)
    }
    
    var i: Int = 1
    for element in container {
        XCTAssertEqual(element, i, "Bad DoubleEndedContainer subscript")
        ++i
    }
    
    let pos = testLength / 2
    container[pos] = 34
    XCTAssertEqual(container[pos], 34, "LinkedList subscript failed")
    
    container.removeAll()
}

func testDECRemoveAll<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    
    testDECEmpty(&container)
    
    for _ in 1...min(3, testLength) {
        container.pushFront(1)
    }
    XCTAssert(container.count > 0, "Count should be greater than zero")
    XCTAssertNotNil(container.isEmpty, "Container should not be empty")
    container.removeAll()
    testDECEmpty(&container)
}

/**
    Test a DoubleEndedContainer with Int type.
    The container should be empty at start and will be empty at end.
*/
func testDoubleEndedContainer<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    testDECEmpty(&container)
    
    // Try all combinations of push/pop back/front
    testDECPushBack(&container)
    testDECPopBack(&container)
    
    testDECPushBack(&container)
    testDECPopFront(&container)
    
    testDECPushFront(&container)
    testDECPopBack(&container)
    
    testDECPushFront(&container)
    testDECPopFront(&container)
    
    testDECSubscript(&container)
    
    testDECRemoveAll(&container)
    
    testDECEmpty(&container)
}


class DECTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        XCTAssert(testLength > 2, "lengthTest is too small for testing")
    }
    
    
    func queueTest<T: QueueType where T.Generator.Element == Int>(inout queue: T) {
        XCTAssert(queue.count == 0)
        XCTAssert(queue.isEmpty)
        
        XCTAssertNil(queue.front)
        XCTAssertNil(queue.back)
        XCTAssertNil(queue.popFront())
    }
    
    func testQueue() {
        
    }
    
}
