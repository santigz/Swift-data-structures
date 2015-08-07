//
//  QueueTests.swift
//
//  Created by Deckard on 27/08/2014.
//  Copyright (c) 2014 Santiago González. All rights reserved.
//

import Cocoa
import XCTest

class QueueTests: XCTestCase {
    
    /// Test the Queue interfaces with Int type
    func queueTest<Q: Queue where Q.ItemType == Int>(inout q: Q) {
        q.enqueueTail(3)
        q.enqueueTail(5)
        assert(q.tail == 5, "Bad tail")
        assert(q.head == 3, "Bad head")
    }
    
    func testArrayQueue() {
        var queue = ArrayQueue<Int>(capacity: 6)
        queueTest(&queue)
    }
    
}
