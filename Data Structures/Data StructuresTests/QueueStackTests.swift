//
//  QueueTests.swift
//
//  Copyright (c) 2015 Santiago González.
//

import Cocoa
import XCTest

class QueueTests: XCTestCase {
    
    let testLength = 100
    
    override func setUp() {
        super.setUp()
        assert(testLength > 2, "lengthTest is too small")
    }
    
    /**
        Test a Queue with Int type.
        The queue should be empty at start and will be empty at end
     */
    func doubleEndedContainerTest<T: DoubleEndedContainer where T.Element == Int>(inout container: T) {
        assert(container.count == 0, "Count should be zero")
        assert(container.isEmpty, "Queue should be empty")
        
        // Test pushFront()
        for element in 1...testLength {
            container.pushFront(element)
            assert(container.count == element, "Queue should have \(element) elements")
            assert(!container.isEmpty, "Queue should not be empty")
            assert(container.front == element, "Bad front")
            assert(container.back == 1, "Bad back")
        }
        
        // Test popFront()
        for element in reverse(1...(testLength - 1)) {
            container.popFront()
            assert(container.count == element, "Queue should have \(element) elements")
            assert(!container.isEmpty, "Queue should not be empty")
            assert(container.back == 1, "Bad back")
            assert(container.front == element, "Bad front")
        }
        container.popFront()
        assert(container.count == 0, "Queue should have 0 elements")
        assert(container.isEmpty, "Queue should be empty")
        assert(container.front == nil, "Bad front")
        assert(container.back == nil, "Bad back")
        
        // Test pushBack()
        for element in 1...testLength {
            container.pushBack(element)
            assert(container.count == element, "BidirectionalContainer should have \(element) elements")
            assert(!container.isEmpty, "BidirectionalContainer should not be empty")
            assert(container.back == element, "Bad front")
            assert(container.front == 1, "Bad back")
        }
        
        // Test popBack()
        for element in reverse(1...(testLength - 1)) {
            container.popBack()
            let count = testLength - element
            assert(container.count == element, "Queue should have \(element) elements")
            assert(!container.isEmpty, "Queue should not be empty")
            assert(container.front == 1, "Bad front")
            assert(container.back == element, "Bad back")
        }
        container.popBack()
        assert(container.count == 0, "Queue should have 0 elements")
        assert(container.isEmpty, "Queue should be empty")
        assert(container.front == nil, "Bad front")
        assert(container.back == nil, "Bad back")
        
        // Test purge
        for _ in 1...min(3, testLength) {
            container.pushFront(1)
        }
        assert(container.count > 0, "Count should be zero")
        assert(!container.isEmpty, "Queue should be empty")
        container.purge()
        assert(container.count == 0, "Count should be zero")
        assert(container.isEmpty, "Queue should be empty")
    }
    
    /**
        Test a Stack with Int type.
        The stack should be empty at start and will be empty at end
     */
    func stackTest<T: Stack where T.Element == Int>(inout queue: T) {
        assert(queue.count == 0, "Count should be zero")
        assert(queue.isEmpty, "Queue should be empty")
        
        // Test: push
        for element in 1...testLength {
            queue.pushBack(element)
            assert(queue.count == element, "Queue should have \(element) elements")
            assert(!queue.isEmpty, "Queue should not be empty")
            assert(queue.back == element, "Bad back")
            assert(queue.front == 1, "Bad front")
        }

        // Test popFront()
        for element in reverse(1...(testLength - 1)) {
            queue.popBack()
            assert(queue.count == element, "Queue should have \(element) elements")
            assert(!queue.isEmpty, "Queue should not be empty")
            assert(queue.back == element, "Bad back")
            assert(queue.front == 1, "Bad front")
        }
        queue.popBack()
        assert(queue.count == 0, "Queue should have 0 elements")
        assert(queue.isEmpty, "Queue should be empty")
        assert(queue.front == nil, "Bad front")
        assert(queue.back == nil, "Bad back")

        // Test purge
        for _ in 1...min(3, testLength) {
            queue.pushBack(1)
        }
        assert(queue.count > 0, "Count should be zero")
        assert(!queue.isEmpty, "Queue should be empty")
        queue.purge()
        assert(queue.count == 0, "Count should be zero")
        assert(queue.isEmpty, "Queue should be empty")
    }
    
    func testCircularArray() {
        var circarray = CircularArray<Int>(capacity: testLength)
        assert(!circarray.isFull, "BidirectionalContainer should not be full")
        assert(circarray.capacity == testLength, "Bad BidirectionalContainer capacity")
        
        doubleEndedContainerTest(&circarray)
        
        // Other CircularArray tests
        for _ in 1...testLength {
            circarray.pushFront(1)
        }
        assert(circarray.isFull, "CircularArray should be full")
        assert(circarray.capacity == testLength, "Bad CircularArray capacity")
    }
    
    func testCircularArrayPerformance() {
        self.measureBlock() {
            let length = 100
            var circarray = CircularArray<Int>(capacity: length)
            for _ in 1...length {
                circarray.pushFront(1)
            }
            for _ in 1...length {
                circarray.popBack()
            }
        }
    }
    
    func testLinkedList() {
//        var llist = LinkedList<Int>()
//        queueTest(&llist)
//        stackTest(&llist)
//        bidirectionalContainerTest(&llist)
    }
    
}
