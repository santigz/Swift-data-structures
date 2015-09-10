//
//  CircularArrayTests.swift
//  DataStructures
//
//  Created by Santiago González on 26/08/2015.
//  Copyright © 2015 sangonz. All rights reserved.
//

import XCTest

class CircularArrayTests: XCTestCase {
    
    func testCircularArray() {
        let circarray = CircularArray<Int>(capacity: 100)
        testDeque(circarray, length: 100)
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
