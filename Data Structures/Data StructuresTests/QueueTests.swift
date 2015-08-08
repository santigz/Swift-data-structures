//
//  QueueTests.swift
//
//  Created by Deckard on 27/08/2014.
//  Copyright (c) 2014 Santiago González. All rights reserved.
//

import Cocoa
import XCTest

class QueueTests: XCTestCase {
    
    let lengthTest = 100
    
    override func setUp() {
        super.setUp()
        assert(lengthTest > 2, "lengthTest is too small")
    }
    
    /// Test a Queue with Int type.
    /// The queue should be empty at start and will be empty at end
    func queueTest<T: Queue where T.ItemType == Int>(inout queue: T) {
        assert(queue.count == 0, "Count should be zero")
        assert(queue.isEmpty, "Queue should be empty")
        
        // Test enqueueTail()
        for element in 1...lengthTest {
            queue.enqueueTail(element)
            assert(queue.count == element, "Queue should have \(element) elements")
            assert(!queue.isEmpty, "Queue should not be empty")
            assert(queue.tail == element, "Bad tail")
            assert(queue.head == 1, "Bad head")
        }
        
        // Test dequeueHead()
        for element in 1...(lengthTest - 1) {
            queue.dequeueHead()
            let count = lengthTest - element
            assert(queue.count == count, "Queue should have \(count) elements")
            assert(!queue.isEmpty, "Queue should not be empty")
            assert(queue.tail == lengthTest, "Bad tail")
            assert(queue.head == element + 1, "Bad head")
        }
        queue.dequeueHead()
        assert(queue.count == 0, "Queue should have 0 elements")
        assert(queue.isEmpty, "Queue should be empty")
        assert(queue.tail == nil, "Bad tail")
        assert(queue.head == nil, "Bad head")
        
        // Test purge
        for _ in 1...min(3, lengthTest) {
            queue.enqueueTail(1)
        }
        assert(queue.count > 0, "Count should be zero")
        assert(!queue.isEmpty, "Queue should be empty")
        queue.purge()
        assert(queue.count == 0, "Count should be zero")
        assert(queue.isEmpty, "Queue should be empty")
    }
    
    /// Test a Stack with Int type.
    /// The queue should be empty at start and will be empty at end
    func stackTest<T: Stack where T.ItemType == Int>(inout stack: T) {
        assert(stack.count == 0, "Count should be zero")
        assert(stack.isEmpty, "Queue should be empty")
        
        // Test enqueueTail()
        for element in 1...lengthTest {
            stack.enqueueTail(element)
            assert(stack.count == element, "Queue should have \(element) elements")
            assert(!stack.isEmpty, "Queue should not be empty")
            assert(stack.tail == element, "Bad tail")
            assert(stack.head == 1, "Bad head")
        }
        
        // Test dequeueTail()
        for element in reverse(1...(lengthTest - 1)) {
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
        for _ in 1...min(3, lengthTest) {
            stack.enqueueTail(1)
        }
        assert(stack.count > 0, "Count should be zero")
        assert(!stack.isEmpty, "Queue should be empty")
        stack.purge()
        assert(stack.count == 0, "Count should be zero")
        assert(stack.isEmpty, "Queue should be empty")
    }
    
    func testCircularArray() {
        var circarray = CircularArray<Int>(capacity: lengthTest)
        assert(!circarray.isFull, "ArrayQueue should not be full")
        assert(circarray.capacity == lengthTest, "Bad ArrayQueue capacity")
        
        // Test as Queue and Stack
        queueTest(&circarray)
        stackTest(&circarray)
        
        // Test enqueueHead(), not tested in Queue nor Stack
        for element in 1...lengthTest {
            circarray.enqueueHead(element)
            assert(circarray.count == element, "Queue should have \(element) elements")
            assert(!circarray.isEmpty, "Queue should not be empty")
            assert(circarray.head == element, "Bad tail")
            assert(circarray.tail == 1, "Bad head")
        }
        
        // Test full CircularArray
        assert(circarray.isFull, "ArrayQueue should be full")
        assert(circarray.capacity == lengthTest, "Bad ArrayQueue capacity")
    }
    
}
