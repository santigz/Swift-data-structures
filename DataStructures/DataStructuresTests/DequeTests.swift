//
//  DequeTests.swift
//  DataStructures
//
//  Created by Santiago González on 27/08/2015.
//  Copyright © 2015 sangonz. All rights reserved.
//

import XCTest

/// Test a Deque that should be empty
func testEmptyDeque<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    testEmptyQueue(deque)
    XCTAssertNil(deque.back)
    XCTAssertNil(deque.front)
    XCTAssertNil(deque.popBack())
    XCTAssertNil(deque.popFront())
}

/// - Requires: `deque.isEmpty`
func testEmptyDequeBack<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    XCTAssert(deque.isEmpty, "This test requires an empty container")
    
    // Assign nil to an empty front
    testEmptyDeque(deque)
    deque.back = nil
    XCTAssertNil(deque.back)
    XCTAssertNil(deque.front)
    testEmptyDeque(deque)
    
    // Assign a value to an empty deque
    let testValue = 8347
    deque.back = testValue
    XCTAssertEqual(deque.back, testValue)
    XCTAssertEqual(deque.front, testValue)
    testFilledDeque(deque)
    deque.back = nil
    XCTAssertNil(deque.back)
    XCTAssertNil(deque.front)
    testEmptyDeque(deque)
}

/// - Requires: `deque.isEmpty`
func testEmptyDequeFront<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    XCTAssert(deque.isEmpty, "This test requires an empty container")
    
    // Assign nil to an empty front
    testEmptyDeque(deque)
    deque.front = nil
    XCTAssertNil(deque.back)
    XCTAssertNil(deque.front)
    testEmptyDeque(deque)
    
    // Assign a value to an empty deque
    let testValue = 5128
    deque.front = testValue
    XCTAssertEqual(deque.back, testValue)
    XCTAssertEqual(deque.front, testValue)
    testFilledDeque(deque)
    deque.front = nil
    XCTAssertNil(deque.back)
    XCTAssertNil(deque.front)
    testEmptyDeque(deque)
}

/// Test `deque.back`. The container may be empty of filled
/// - Requires: `!deque.isEmpty`
func testFilledDequeBack<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    XCTAssertFalse(deque.isEmpty, "This test requires a container with contents")
    
    let prevCount = deque.count
    let back = deque.back
    let testValue = 1928
    
    deque.back = nil
    XCTAssertEqual(deque.count, prevCount - 1)
    deque.pushBack(testValue)
    XCTAssertEqual(deque.back, testValue)
    
    deque.back = back
    XCTAssertEqual(deque.back, back)
    XCTAssertEqual(deque.count, prevCount)
}

/// Test `deque.front` when the container is not empty
/// - Requires: `!deque.isEmpty`
func testFilledDequeFront<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    XCTAssertFalse(deque.isEmpty, "This test requires a container with contents")
    
    let prevCount = deque.count
    let front = deque.front
    let testValue = 29184
    
    deque.front = nil
    XCTAssertEqual(deque.count, prevCount - 1)
    deque.pushFront(testValue)
    XCTAssertEqual(deque.front, testValue)
    
    deque.front = front
    XCTAssertEqual(deque.front, front)
    XCTAssertEqual(deque.count, prevCount)
}

/// Test a Deque that is not empty
/// - Requires: `!deque.isEmpty`
func testFilledDeque<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    XCTAssertFalse(deque.isEmpty, "This test requires a container with contents")
    
    testFilledQueue(deque)
    
    let back = deque.back
    let front = deque.front
    XCTAssertNotNil(back)
    XCTAssertNotNil(front)
    
    // Test popFront()
    let popFront = deque.popFront()
    XCTAssertEqual(front, popFront)
    // Test pushFront()
    XCTAssertNotEqual(front, deque.front)
    deque.pushFront(popFront!)
    XCTAssertEqual(front, deque.front)
}

/// - Requires: `!deque.isEmpty`
func testPushFrontOnEnds<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    XCTAssert(deque.isEmpty, "This test requires an empty container")
    
    XCTAssertNil(deque.back)
    XCTAssertNil(deque.front)
    
    let testValue1 = 2134
    let testValue2 = 817
    deque.pushFront(testValue1)
    XCTAssertEqual(deque.back, testValue1)
    XCTAssertEqual(deque.front, testValue1)
    deque.pushFront(testValue2)
    XCTAssertEqual(deque.back, testValue1)
    XCTAssertEqual(deque.front, testValue2)
    let back = deque.popBack()
    XCTAssertEqual(back, testValue1)
    XCTAssertEqual(deque.back, testValue2)
    XCTAssertEqual(deque.front, testValue2)
    deque.popFront()
    testEmptyDeque(deque)
}

/// `pushFront()` in a deque to insert the data: (front) 1...testLength (back)
/// - Requires: `deque.isEmpty`
func testPushFront<T: DequeType where T.Generator.Element == Int>(inout deque: T) {
    testEmptyDeque(deque)
    for element in Array((1...testLength).reverse()) {
        deque.pushFront(element)
        let count = testLength - element + 1
        XCTAssertEqual(deque.count, count, "Container should have \(count) elements")
        XCTAssertNotNil(deque.isEmpty, "Container should not be empty")
        XCTAssertEqual(deque.back, testLength, "Bad back")
        XCTAssertEqual(deque.front, element, "Bad front")
    }
    XCTAssertFalse(deque.isEmpty)
    XCTAssertEqual(deque.count, testLength)
    testFilledDeque(deque)
}

/// `popBack()` from a deque with the data: (front) 1...testLength (back)
func testPopBack<T: DequeType where T.Generator.Element == Int>(inout deque: T) {
    testFilledDeque(deque)
    for element in Array((2...deque.count).reverse()) {
        let popped = deque.popBack()
        XCTAssertEqual(popped!, element, "Bad popFront() element")
        XCTAssertEqual(deque.count, element - 1, "Container should have \(element) elements")
        XCTAssertNotNil(deque.isEmpty, "Container should not be empty")
        XCTAssertEqual(deque.back, element - 1, "Bad back: \(deque.back)")
        XCTAssertEqual(deque.front, 1, "Bad front")
    }
    XCTAssertEqual(deque.popBack(), 1, "Bad popFront() element")
    XCTAssertNil(deque.popBack())
    testEmptyDeque(deque)
}

func testDeque<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    XCTAssert(deque.isEmpty, "This test requires an empty container")
    
    testQueue(deque)
    
    testEmptyDequeBack(deque)
    testEmptyDequeFront(deque)
    
    testPushFront(&deque)
    testFilledDeque(deque)
    testFilledDequeBack(deque)
    testFilledDequeFront(deque)
    testSubscript(deque)
    testPopBack(&deque)
    testEmptyDeque(deque)
}


class DequeTests: XCTestCase {

    func testCircularArrayDeque() {
        let deque = CircularArrayDeque<Int>(capacity: testLength)
        testDeque(deque)
    }
    
    func testLinkedListDeque() {
        let deque = LinkedListDeque<Int>()
        testDeque(deque)
    }
    
}
