//
//  Data_StructuresTests.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Cocoa
import XCTest

var nElementsDeinitialized = 0

class DataStructuresTests: XCTestCase {
    
    // Size of the arrays for testing
    let testLength = 100
    
    override func setUp() {
        super.setUp()
        XCTAssert(testLength > 2, "lengthTest is too small for testing")
    }
    
    func doubleEndedContainerEmptyTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
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
    
    func doubleEndedContainerFullTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
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
    func doubleEndedContainerPushBackTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        
        doubleEndedContainerEmptyTest(&container)
        
        for element in 1...testLength {
            container.pushBack(element)
            XCTAssertEqual(container.count, element, "Container should have \(element) elements")
            XCTAssertNotNil(container.isEmpty, "Container should not be empty")
            XCTAssertEqual(container.back, element, "Bad back")
            XCTAssertEqual(container.front, 1, "Bad front")
        }
        
        doubleEndedContainerFullTest(&container)
    }
    
    
    /**
      pushFront in a container to insert the data: (front) 1...testLength (back)
    */
    func doubleEndedContainerPushFrontTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        
        doubleEndedContainerEmptyTest(&container)
        
        for element in Array((1...testLength).reverse()) {
            container.pushFront(element)
            let count = testLength - element + 1
            XCTAssertEqual(container.count, count, "Container should have \(count) elements")
            XCTAssertNotNil(container.isEmpty, "Container should not be empty")
            XCTAssertEqual(container.back, testLength, "Bad back")
            XCTAssertEqual(container.front, element, "Bad front")
        }
        
        doubleEndedContainerFullTest(&container)
    }
    
    /**
      popBack from a container with the data: (front) 1...testLength (back)
    */
    func doubleEndedContainerPopBackTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        
        doubleEndedContainerFullTest(&container)
        
        for element in Array((2...testLength).reverse()) {
            let popped = container.popBack()
            XCTAssertEqual(popped!, element, "Bad popFront() element")
            XCTAssertEqual(container.count, element - 1, "Container should have \(element) elements")
            XCTAssertNotNil(container.isEmpty, "Container should not be empty")
            XCTAssertEqual(container.back, element - 1, "Bad back")
            XCTAssertEqual(container.front, 1, "Bad front")
        }
        XCTAssertEqual(container.popBack(), 1, "Bad popFront() element")
        doubleEndedContainerEmptyTest(&container)
    }
    
    /**
        popFront from a container with the data: (front) 1...testLength (back)
     */
    func doubleEndedContainerPopFrontTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {

        doubleEndedContainerFullTest(&container)
        
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
        doubleEndedContainerEmptyTest(&container)
    }
    
    func doubleEndedContainerSubscriptTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
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
    
    func doubleEndedContainerRemoveAllTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        
        doubleEndedContainerEmptyTest(&container)
        
        for _ in 1...min(3, testLength) {
            container.pushFront(1)
        }
        XCTAssert(container.count > 0, "Count should be greater than zero")
        XCTAssertNotNil(container.isEmpty, "Container should not be empty")
        container.removeAll()
        doubleEndedContainerEmptyTest(&container)
    }
    
    /**
        Test a DoubleEndedContainer with Int type.
        The container should be empty at start and will be empty at end.
        
        This also tests Queue, Deque and Stack, which are a subset of DoubleEndedContainer
     */
    func doubleEndedContainerTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        XCTAssertEqual(container.count, 0, "Count should be zero")
        XCTAssert(container.isEmpty, "Container should be empty")
        
        // Try all combinations of push/pop back/front
        doubleEndedContainerPushBackTest(&container)
        doubleEndedContainerPopBackTest(&container)
        
        doubleEndedContainerPushBackTest(&container)
        doubleEndedContainerPopFrontTest(&container)
        
        doubleEndedContainerPushFrontTest(&container)
        doubleEndedContainerPopBackTest(&container)
        
        doubleEndedContainerPushFrontTest(&container)
        doubleEndedContainerPopFrontTest(&container)
        
        doubleEndedContainerSubscriptTest(&container)
        
        doubleEndedContainerRemoveAllTest(&container)
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
    
    func testCircularArray() {
        var circarray = CircularArray<Int>(capacity: testLength)
        XCTAssertNotNil(circarray.isFull)
        XCTAssert(circarray.capacity == testLength)
        
        doubleEndedContainerTest(&circarray)
        
        // Other CircularArray tests
        for i in 1...testLength {
            circarray.pushBack(i)
        }
        
        var i = 1
        for element in circarray {
            XCTAssert(element == i, "Bad CircularArray element while looping")
            ++i
        }

        let pos = testLength / 2
        circarray[pos] = 34
        XCTAssert(circarray[pos] == 34, "CircularArray subscript failed")
        
        XCTAssert(circarray.isFull)
        XCTAssert(circarray.capacity == testLength)
    }
    
    func testCircularArrayPerformance() {
        self.measureBlock() {
            let length = 1000
            var circarray = CircularArray<Int>(capacity: length)
            for _ in 1...length {
                circarray.pushFront(1)
            }
            for _ in 1...length {
                circarray.popBack()
            }
        }
    }
    
    
    class TestElement {
        deinit {
            ++nElementsDeinitialized
        }
    }
    
    func testLinkedList() {
        var llist = LinkedList<Int>()
        doubleEndedContainerTest(&llist)
        
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
