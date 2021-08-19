//
//  NeptuneCalculatorTests.swift
//  NeptuneTests
//
//  Created by Lucas Kellar on 2021-02-24.
//

import XCTest

@testable import Neptune

class NeptuneCalculatorTests: XCTestCase {

    func testInHouseCalculate() throws {
        self.measure {
            calculate(equation: "3x+2", start: -10, end: 10, step: 0.02)
        }
    }

}
