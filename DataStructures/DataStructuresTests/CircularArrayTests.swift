//
//  CircularArrayTests.swift
//  DataStructures
//
//  Created by Santiago González on 26/08/2015.
//  Copyright © 2015 sangonz. All rights reserved.
//

import XCTest

class CircularArrayTests: XCTestCase {
    
    // Size of the arrays for testing
    let testLength = 100
    
    override func setUp() {
        super.setUp()
        XCTAssert(testLength > 2, "lengthTest is too small for testing")
    }
    
    func testCircularArray() {
        var circarray = CircularArray<Int>(capacity: testLength)
        XCTAssertNotNil(circarray.isFull)
        XCTAssertEqual(circarray.capacity, testLength)
        
        testDoubleEndedContainer(&circarray)
        
        // Other CircularArray tests
        for i in 1...testLength {
            circarray.pushBack(i)
        }
        
        var i = 1
        for element in circarray {
            XCTAssertEqual(element, i, "Bad CircularArray element while looping")
            ++i
        }
        
        let pos = testLength / 2
        circarray[pos] = 34
        XCTAssert(circarray[pos] == 34, "CircularArray subscript failed")
        
        XCTAssert(circarray.isFull)
        XCTAssertEqual(circarray.capacity, testLength)
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


}
