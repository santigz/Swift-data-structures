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
    func queueTest<T: Queue where T.ItemType == Int>(inout queue: T) {
        assert(queue.count == 0, "Count should be zero")
        assert(queue.isEmpty, "Queue should be empty")
        
        // Test enqueueTail()
        for element in 1...testLength {
            queue.enqueueTail(element)
            assert(queue.count == element, "Queue should have \(element) elements")
            assert(!queue.isEmpty, "Queue should not be empty")
            assert(queue.tail == element, "Bad tail")
            assert(queue.head == 1, "Bad head")
        }
        
        // Test dequeueHead()
        for element in 1...(testLength - 1) {
            queue.dequeueHead()
            let count = testLength - element
            assert(queue.count == count, "Queue should have \(count) elements")
            assert(!queue.isEmpty, "Queue should not be empty")
            assert(queue.tail == testLength, "Bad tail")
            assert(queue.head == element + 1, "Bad head")
        }
        queue.dequeueHead()
        assert(queue.count == 0, "Queue should have 0 elements")
        assert(queue.isEmpty, "Queue should be empty")
        assert(queue.tail == nil, "Bad tail")
        assert(queue.head == nil, "Bad head")
        
        // Test purge
        for _ in 1...min(3, testLength) {
            queue.enqueueTail(1)
        }
        assert(queue.count > 0, "Count should be zero")
        assert(!queue.isEmpty, "Queue should be empty")
        queue.purge()
        assert(queue.count == 0, "Count should be zero")
        assert(queue.isEmpty, "Queue should be empty")
    }
    
    /**
        Test a Stack with Int type.
        The stack should be empty at start and will be empty at end
     */
    func stackTest<T: Stack where T.ItemType == Int>(inout stack: T) {
        assert(stack.count == 0, "Count should be zero")
        assert(stack.isEmpty, "Queue should be empty")
        
        // Test enqueueTail()
        for element in 1...testLength {
            stack.enqueueTail(element)
            assert(stack.count == element, "Queue should have \(element) elements")
            assert(!stack.isEmpty, "Queue should not be empty")
            assert(stack.tail == element, "Bad tail")
            assert(stack.head == 1, "Bad head")
        }
        
        // Test dequeueTail()
        for element in reverse(1...(testLength - 1)) {
            stack.dequeueTail()
            assert(stack.count == element, "Queue should have \(element) elements")
            assert(!stack.isEmpty, "Queue should not be empty")
            assert(stack.head == 1, "Bad head")
            assert(stack.tail == element, "Bad tail")
        }
        stack.dequeueTail()
        assert(stack.count == 0, "Queue should have 0 elements")
        assert(stack.isEmpty, "Queue should be empty")
        assert(stack.tail == nil, "Bad tail")
        assert(stack.head == nil, "Bad head")
        
        // Test purge
        for _ in 1...min(3, testLength) {
            stack.enqueueTail(1)
        }
        assert(stack.count > 0, "Count should be zero")
        assert(!stack.isEmpty, "Queue should be empty")
        stack.purge()
        assert(stack.count == 0, "Count should be zero")
        assert(stack.isEmpty, "Queue should be empty")
    }
    
    /**
        Test a BidirectionalContainer with Int type.
        The container should be empty at start and will be empty at end.
        It does not test the methods in Stack or Queue
     */
    func bidirectionalContainerTest<T: BidirectionalContainer where T.ItemType == Int>(inout container: T) {
        
        // Test enqueueHead(), not tested in Queue nor Stack
        for element in 1...testLength {
            container.enqueueHead(element)
            assert(container.count == element, "BidirectionalContainer should have \(element) elements")
            assert(!container.isEmpty, "BidirectionalContainer should not be empty")
            assert(container.head == element, "Bad tail")
            assert(container.tail == 1, "Bad head")
        }
        
        container.purge()
        assert(container.count == 0, "Count should be zero")
        assert(container.isEmpty, "BidirectionalContainer should be empty")
    }
    
    func testCircularArray() {
        var circarray = CircularArray<Int>(capacity: testLength)
        assert(!circarray.isFull, "BidirectionalContainer should not be full")
        assert(circarray.capacity == testLength, "Bad BidirectionalContainer capacity")
        
        queueTest(&circarray)
        stackTest(&circarray)
        bidirectionalContainerTest(&circarray)
        
        // Other CircularArray tests
        for _ in 1...testLength {
            circarray.enqueueTail(1)
        }
        assert(circarray.isFull, "CircularArray should be full")
        assert(circarray.capacity == testLength, "Bad CircularArray capacity")
    }
    
    func testCircularArrayPerformance() {
        self.measureBlock() {
            let length = 100
            var circarray = CircularArray<Int>(capacity: length)
            for _ in 1...length {
                circarray.enqueueTail(1)
            }
            for _ in 1...length {
                circarray.dequeueHead()
            }
        }
        
    }
    
}
