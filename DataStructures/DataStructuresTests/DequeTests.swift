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
    
    XCTAssertNil(deque.back)
    XCTAssertNil(deque.front)
    
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
    XCTAssert(deque.count > 1, "This test requires more than one element inserted")
    
    XCTAssertNotNil(deque.back)
    XCTAssertNotNil(deque.front)
    
    // Correspondance with subscripts
    XCTAssertEqual(deque.front, deque[0])
    XCTAssertEqual(deque.back, deque[deque.count - 1])
    
    let prevCount = deque.count
    let prevBack = deque[deque.count - 2]
    let front = deque.front
    let back = deque.back
    let testValue1 = 1928
    let testValue2 = 21637
    
    deque.back = nil
    XCTAssertEqual(deque.back, prevBack)
    XCTAssertEqual(deque.front, front)
    XCTAssertEqual(deque.count, prevCount - 1)
    XCTAssertEqual(deque.back, deque[deque.count - 1])
    
    deque.pushBack(testValue1)
    XCTAssertEqual(deque.back, testValue1)
    XCTAssertEqual(deque.count, prevCount)
    
    deque.back = testValue2
    XCTAssertEqual(deque.count, prevCount)
    XCTAssertEqual(deque.back, testValue2)
    XCTAssertEqual(testValue2, deque[deque.count - 1])
    
    deque.back = back
    XCTAssertEqual(deque.back, back)
    XCTAssertEqual(deque.count, prevCount)
    XCTAssertEqual(deque.front, front)
}

/// Test `deque.front` when the container is not empty
/// - Requires: `!deque.isEmpty`
func testFilledDequeFront<T: DequeType where T.Generator.Element == Int>(var deque: T) {
    XCTAssertFalse(deque.isEmpty, "This test requires a container with contents")
    XCTAssert(deque.count > 1, "This test requires more than one element inserted")
    
    XCTAssertNotNil(deque.back)
    XCTAssertNotNil(deque.front)
    
    // Correspondance with subscripts
    XCTAssertEqual(deque.front, deque[0])
    XCTAssertEqual(deque.back, deque[deque.count - 1])
    
    let prevCount = deque.count
    let front = deque.front
    let back = deque.back
    let testValue = 29184
    
    deque.front = nil
    XCTAssertNotNil(deque.front)
    XCTAssertEqual(deque.count, prevCount - 1)
    XCTAssertEqual(deque.back, back)
    XCTAssertEqual(deque.front, deque[0])
    XCTAssertEqual(deque.count, prevCount - 1)
    
    deque.pushFront(testValue)
    XCTAssertEqual(deque.front, testValue)
    
    deque.front = front
    XCTAssertEqual(deque.front, front)
    XCTAssertEqual(deque.count, prevCount)
    XCTAssertEqual(deque.back, back)
    
    deque[deque.count - 1] = testValue
    XCTAssertEqual(deque.back, testValue, "Setting a new value in the last subscript should be reflected in the back")
    deque[0] = testValue
    XCTAssertEqual(deque.front, testValue, "Setting a new value in the first subscript should be reflected in the front")
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

/// `pushFront()` in a deque to insert the data: (front) 1...length (back)
/// - Requires: `deque.isEmpty`
func testPushFront<T: DequeType where T.Generator.Element == Int>(inout deque: T, length: Int) {
    testEmptyDeque(deque)
    for element in Array((1...length).reverse()) {
        deque.pushFront(element)
        let count = length - element + 1
        XCTAssertEqual(deque.count, count, "Container should have \(count) elements")
        XCTAssertNotNil(deque.isEmpty, "Container should not be empty")
        XCTAssertEqual(deque.back, length, "Bad back")
        XCTAssertEqual(deque.front, element, "Bad front")
        XCTAssertEqual(deque[0], deque.front)
        XCTAssertEqual(deque[deque.count - 1], deque.back)
    }
    XCTAssertFalse(deque.isEmpty)
    XCTAssertEqual(deque.count, length)
    testFilledDeque(deque)
}

/// `popBack()` from a deque with the data: (front) 1...deque.count (back)
func testPopBack<T: DequeType where T.Generator.Element == Int>(inout deque: T) {
    testFilledDeque(deque)
    for element in Array((2...deque.count).reverse()) {
        let popped = deque.popBack()
        XCTAssertEqual(popped!, element, "Bad popFront() element")
        XCTAssertEqual(deque.count, element - 1, "Container should have \(element) elements")
        XCTAssertNotNil(deque.isEmpty, "Container should not be empty")
        XCTAssertEqual(deque.back, element - 1, "Bad back: \(deque.back) for element \(element)")
        XCTAssertEqual(deque.front, 1, "Bad front")
        XCTAssertEqual(deque[0], deque.front)
        XCTAssertEqual(deque[deque.count - 1], deque.back)
    }
    XCTAssertEqual(deque.popBack(), 1, "Bad popFront() element")
    XCTAssertNil(deque.popBack())
    testEmptyDeque(deque)
}

func testDeque<T: DequeType where T.Generator.Element == Int>(var deque: T, length: Int) {
    XCTAssert(deque.isEmpty, "This test requires an empty container")
    
    testQueue(deque, length: length)
    
    testEmptyDequeBack(deque)
    testEmptyDequeFront(deque)
    
    let filledDequeTests = {(deque: T) in
        testFilledDeque(deque)
        testFilledDequeBack(deque)
        testFilledDequeFront(deque)
        testSubscript(deque)
    }
    
    // Try all combinations of push/pop back/front
    testPushFront(&deque, length: length)
    filledDequeTests(deque)
    testPopBack(&deque)
    testEmptyDeque(deque)
    
    testPushFront(&deque, length: length)
    filledDequeTests(deque)
    testPopFront(&deque)
    testEmptyDeque(deque)
    
    testPushBack(&deque, length: length)
    filledDequeTests(deque)
    testPopBack(&deque)
    testEmptyDeque(deque)
    
    testPushBack(&deque, length: length)
    filledDequeTests(deque)
    testPopFront(&deque)
    testEmptyDeque(deque)
}


class DequeTests: XCTestCase {
    
    func testCircularArrayDeque() {
        for capacity in [100, 500, 1000] {
            let deque = CircularArrayDeque<Int>(capacity: capacity)
            testDeque(deque, length: 100)
        }
    }
    
    func testLinkedListDeque() {
        let deque = LinkedListDeque<Int>()
        testDeque(deque, length: 100)
    }
    
}
