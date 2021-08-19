//
//  NeptuneBoundsTests.swift
//  NeptuneMacTests
//
//  Created by Lucas Kellar on 7/31/21.
//

import XCTest

@testable import Neptune

class NeptuneBoundsTests: XCTestCase {

    func testAddition() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let lhs = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
        let rhs = Bounds(topLeft: CGPoint(x: 10, y: 10), lowerRight: CGPoint(x: 20, y: -10))
        let result = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 20, y: -10))
        XCTAssertEqual(lhs + rhs, result)
    }
    
    func testOverlappingAddition() throws {
        let lhs = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
        let rhs = Bounds(topLeft: CGPoint(x: -10, y: 5), lowerRight: CGPoint(x: 20, y: -10))
        let result = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 20, y: -10))
        XCTAssertEqual(lhs + rhs, result)
    }
    
    func testHorizontalSubtraction() throws {
        let lhs = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
        let rhs = Bounds(topLeft: CGPoint(x: 0, y: 10), lowerRight: CGPoint(x: 10, y: -10))
        let result = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 0, y: -10))
        XCTAssertEqual(lhs - rhs, result)
    }
    
    func testVerticalSubtraction() throws {
        let lhs = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
        let rhs = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: 0))
        let result = Bounds(topLeft: CGPoint(x: -10, y: 0), lowerRight: CGPoint(x: 10, y: -10))
        XCTAssertEqual(lhs - rhs, result)
    }
    
    func testAlternativeSubtraction()  throws {
        let lhs = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
        let rhs = Bounds(topLeft: CGPoint(x: -10, y: 0), lowerRight: CGPoint(x: 10, y: -10))
        let result = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: 0))
        XCTAssertEqual(lhs - rhs, result)
    }

}
