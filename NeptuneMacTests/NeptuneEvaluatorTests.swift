//
//  NeptuneEvaluatorTests.swift
//  NeptuneTests
//
//  Created by Lucas Kellar on 2021-02-23.
//

import XCTest

@testable import Neptune

class NeptuneEvaluatorTests: XCTestCase {

    func testBasicAddition() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(evaluate(["3", "5", "+"]), 8)
    }

    func testBasicSubtraction() throws {
        XCTAssertEqual(evaluate(["3", "5", "-"]), -2)
    }

    func testBasicMultiplication() throws {
        XCTAssertEqual(evaluate(["3", "5", "*"]), 15)
    }

    func testBasicDivision() throws {
        XCTAssertEqual(evaluate(["3", "5", "/"]), 0.6)
    }

    func testMixAdditionDivision() throws {
        XCTAssertEqual(evaluate(["3", "5", "6", "/", "+"]), 23/6)
    }

    func testMixMultiplicationDivision() throws {
        XCTAssertEqual(evaluate(["3", "5", "*", "6", "/"]), 2.5)
    }

    func testMixAddSubtractMultiplyDivide() throws {
        XCTAssertEqual(evaluate(["1", "2", "3", "/", "4", "*", "+"]), 11/3)
    }

    func testSin() throws {
        XCTAssertEqual(evaluate(["3", "sin"]), sin(3))
    }

    func testCos() throws {
        XCTAssertEqual(evaluate(["2", "cos"]), cos(2))
    }

    func testTan() throws {
        XCTAssertEqual(evaluate(["5", "tan"]), tan(5))
    }

    func testParantheses() throws {
        XCTAssertEqual(evaluate(["5", "8", "+", "3", "*"]), 39)
    }

    func testAsin() throws {
        XCTAssertEqual(evaluate(["0.9", "asin"]), asin(0.9))
    }

    func testAcos() throws {
        XCTAssertEqual(evaluate(["0.9", "acos"]), acos(0.9))
    }

    func testAtan() throws {
        XCTAssertEqual(evaluate(["5", "atan"]), atan(5))
    }

    func testSquareRoot() throws {
        XCTAssertEqual(evaluate(["4", "sqrt"]), 2)
    }

    func testAbs() throws {
        XCTAssertEqual(evaluate(["-4", "abs"]), 4)
    }

    func testNegativeNumber() throws {
        XCTAssertEqual(evaluate(["-4", "3", "+"]), -1)
    }

    func testPiSpelledOut() throws {
        XCTAssertEqual(evaluate(["pi", "2", "*"]), 2*Double.pi)
    }

    func testPiSymbol() throws {
        XCTAssertEqual(evaluate(["2", "π", "*"]), 2*Double.pi)
    }

    func testExponents() throws {
        XCTAssertEqual(evaluate(["2", "5", "^"]), 32)
    }

    func testExponentOOO() throws {
        XCTAssertEqual(evaluate(["5", "pi", "*", "5", "^", "3", "5", "/", "+"]), pow((5*Double.pi), 5) + 0.6)
    }

    func testPiCombineWithNumber() throws {
        XCTAssertEqual(evaluate(["2", "pi", "*"]), 2*Double.pi)
    }

    func testNaturalLog() throws {
        XCTAssertEqual(evaluate(["5", "pi", "*", "ln"]), log(5*Double.pi))
    }

    func testOtherLog() throws {
        XCTAssertEqual(evaluate(["2", "log5"]), logC(2, forBase: 5))
    }

    func testCubeRoot() throws {
        XCTAssertEqual(evaluate(["8", "cbrt"]), 2)
    }

    func testOtherRoot() throws {
        XCTAssertEqual(evaluate(["16", "root4"]), 2)
    }

    func testXVariable() throws {
        XCTAssertEqual(evaluate(["x", "3", "+"], variables: ["x": 5]), 8)
    }

}
