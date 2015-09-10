//
//  Data_StructuresTests.swift
//
//  Copyright (c) 2015 Santiago González.
//

import XCTest

// Size of the arrays for testing
let testLength = 100

/// Test a container that should be empty
func testEmptyContainer<T: Container where T.Generator.Element == Int>(container: T) {
    XCTAssert(container.isEmpty)
    XCTAssertEqual(container.count, 0)
}

func testFilledContainer<T: Container where T.Generator.Element == Int>(container: T) {
    XCTAssertFalse(container.isEmpty)
    XCTAssert(container.count > 0)
}

/// Test the subscripts in a container
func testSubscript<T: Container where T.Generator.Element == Int>(var container: T) {
    testFilledContainer(container)
    var i = 1
    for element in container {
        XCTAssertEqual(element, i, "Bad element looping the container")
        ++i
    }
    XCTAssertEqual(container.count, i - 1, "Bad number of loops")
    
    let pos = min(container.count / 2, container.count - 1)
    let value = container[pos]
    container[pos] = 34
    XCTAssertEqual(container[pos], 34, "Subscript getter failed")
    container[pos] = value
    XCTAssertEqual(container[pos], value, "Subscript setter failed")
}

func testRemoveAll<T: Container where T.Generator.Element == Int>(inout container: T) {
    container.removeAll()
    testEmptyContainer(container)
}

/**
    Test a DoubleEndedContainer with Int type.
    The container should be empty at start and will be empty at end.
 */
func testDoubleEndedContainer<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
    testEmptyContainer(container)
    
    // Try all combinations of push/pop back/front
    testPushBack(&container)
    testSubscript(container)
    testPopBack(&container)
    
    testPushBack(&container)
    testSubscript(container)
    testPopFront(&container)
    
    testPushFront(&container)
    testSubscript(container)
    testPopBack(&container)
    
    testPushFront(&container)
    testSubscript(container)
    testPopFront(&container)
    
    testRemoveAll(&container)
    
    testEmptyContainer(container)
}


class DECTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        XCTAssert(testLength > 2, "lengthTest is too small for testing")
    }
    
}
