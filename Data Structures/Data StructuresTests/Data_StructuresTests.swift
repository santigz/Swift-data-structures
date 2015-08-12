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
        assert(testLength > 2, "lengthTest is too small")
    }
    
    /**
      pushBack in a container to insert the data: (front) 1...testLength (back)
    */
    func doubleEndedContainerPushBackTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        // Test pushBack()
        for element in 1...testLength {
            container.pushBack(element)
            assert(container.count == element, "Container should have \(element) elements")
            assert(!container.isEmpty, "Container should not be empty")
            assert(container.back == element, "Bad front")
            assert(container.front == 1, "Bad back")
        }
    }
    
    
    /**
      pushFront in a container to insert the data: (front) 1...testLength (back)
    */
    func doubleEndedContainerPushFrontTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        // Test pushFront()
        for element in reverse(1...testLength) {
            container.pushFront(element)
            let count = testLength - element + 1
            assert(container.count == count, "Container should have \(count) elements")
            assert(!container.isEmpty, "Container should not be empty")
            assert(container.back == testLength, "Bad back")
            assert(container.front == element, "Bad front")
        }
    }
    
    /**
      popBack from a container with the data: (front) 1...testLength (back)
    */
    func doubleEndedContainerPopBackTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        // Test popBack()
        for element in reverse(2...testLength) {
            let popped = container.popBack()
            assert(popped! == element, "Bad popFront() element")
            assert(container.count == element - 1, "Container should have \(element) elements")
            assert(!container.isEmpty, "Container should not be empty")
            assert(container.back == element - 1, "Bad back")
            assert(container.front == 1, "Bad front")
        }
        let popped = container.popBack()
        assert(popped == 1, "Bad popFront() element")
        assert(container.count == 0, "Container should have 0 elements")
        assert(container.isEmpty, "Container should be empty")
        assert(container.front == nil, "Bad front")
        assert(container.back == nil, "Bad back")
        
        let popped2 = container.popBack()
        assert(popped2 == nil, "Bad popFront() element")
    }
    
    /**
        popFront from a container with the data: (front) 1...testLength (back)
     */
    func doubleEndedContainerPopFrontTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        // Test popFront()
        for element in 1...(testLength - 1) {
            let popped = container.popFront()
            assert(popped! == element, "Bad popFront() element")
            let revelement = testLength - element
            assert(container.count == revelement, "Container should have \(revelement) elements")
            assert(!container.isEmpty, "Container should not be empty")
            assert(container.back == testLength, "Bad back")
            assert(container.front == element + 1, "Bad front")
        }
        let popped = container.popFront()
        assert(popped == testLength, "Bad popFront() element")
        assert(container.count == 0, "Container should have 0 elements")
        assert(container.isEmpty, "Container should be empty")
        assert(container.front == nil, "Bad front")
        assert(container.back == nil, "Bad back")
        
        let popped2 = container.popFront()
        assert(popped2 == nil, "Bad popFront() element")
    }
    
    func doubleEndedContainerSubscriptTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        for element in 1...testLength {
            container.pushBack(element)
        }
        
        var i: Int = 1
        for element in container {
            assert(element == i, "Bad DoubleEndedContainer subscript")
            ++i
        }
        
        let pos = testLength / 2
        container[pos] = 34
        assert(container[pos] == 34, "LinkedList subscript failed")
        
        container.removeAll()
    }
    
    /**
        Test a DoubleEndedContainer with Int type.
        The container should be empty at start and will be empty at end.
        
        This also tests Queue, Deque and Stack, which are a subset of DoubleEndedContainer
     */
    func doubleEndedContainerTest<T: DoubleEndedContainer where T.Generator.Element == Int>(inout container: T) {
        assert(container.count == 0, "Count should be zero")
        assert(container.isEmpty, "Container should be empty")
        
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
        
        // Test removeAll
        for _ in 1...min(3, testLength) {
            container.pushFront(1)
        }
        assert(container.count > 0, "Count should be zero")
        assert(!container.isEmpty, "Container should be empty")
        container.removeAll()
        assert(container.count == 0, "Count should be zero")
        assert(container.isEmpty, "Container should be empty")
    }
    
    func testCircularArray() {
        var circarray = CircularArray<Int>(capacity: testLength)
        assert(!circarray.isFull, "BidirectionalContainer should not be full")
        assert(circarray.capacity == testLength, "Bad BidirectionalContainer capacity")
        
        doubleEndedContainerTest(&circarray)
        
        // Other CircularArray tests
        for i in 1...testLength {
            circarray.pushBack(i)
        }
        
        var i = 1
        for element in circarray {
            assert(element == i, "Bad CircularArray element while looping")
            ++i
        }

        let pos = testLength / 2
        circarray[pos] = 34
        assert(circarray[pos] == 34, "CircularArray subscript failed")
        
        assert(circarray.isFull, "CircularArray should be full")
        assert(circarray.capacity == testLength, "Bad CircularArray capacity")
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
        assert(nElementsDeinitialized == testLength, "Wrong number of deinitializers")
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
