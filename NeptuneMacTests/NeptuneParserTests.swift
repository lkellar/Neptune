//
//  NeptuneParserTests.swift
//  Tests macOS
//
//  Created by Lucas Kellar on 2021-02-07.
//

import XCTest

@testable import Neptune

class NeptuneParserTests: XCTestCase {

    /*override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }*/

    func testBasicAddition() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(parse("3+5")?.joined(separator: " "), "3 5 +")
    }

    func testBasicSubtraction() throws {
        XCTAssertEqual(parse("3-5")?.joined(separator: " "), "3 5 -")
    }

    func testBasicMultiplication() throws {
        XCTAssertEqual(parse("3*5")?.joined(separator: " "), "3 5 *")
    }

    func testBasicDivision() throws {
        XCTAssertEqual(parse("3/5")?.joined(separator: " "), "3 5 /")
    }

    func testMixAdditionDivision() throws {
        XCTAssertEqual(parse("3+5/6")?.joined(separator: " "), "3 5 6 / +")
    }

    func testMixMultiplicationDivision() throws {
        XCTAssertEqual(parse("3*5/6")?.joined(separator: " "), "3 5 * 6 /")
    }

    func testMixAddSubtractMultiplyDivide() throws {
        XCTAssertEqual(parse("1+2/3*4")?.joined(separator: " "), "1 2 3 / 4 * +")
    }

    func testSin() throws {
        XCTAssertEqual(parse("sin(3)")?.joined(separator: " "), "3 sin")
    }

    func testCos() throws {
        XCTAssertEqual(parse("cos(2)")?.joined(separator: " "), "2 cos")
    }

    func testTan() throws {
        XCTAssertEqual(parse("tan(5)")?.joined(separator: " "), "5 tan")
    }

    func testParantheses() throws {
        XCTAssertEqual(parse("(5 + 8) * 3")?.joined(separator: " "), "5 8 + 3 *")
    }

    func testAsin() throws {
        XCTAssertEqual(parse("asin(0.9)")?.joined(separator: " "), "0.9 asin")
    }

    func testAcos() throws {
        XCTAssertEqual(parse("acos(0.9)")?.joined(separator: " "), "0.9 acos")
    }

    func testAtan() throws {
        XCTAssertEqual(parse("atan(5)")?.joined(separator: " "), "5 atan")
    }

    func testSquareRoot() throws {
        XCTAssertEqual(parse("sqrt(4)")?.joined(separator: " "), "4 sqrt")
    }

    func testAbs() throws {
        XCTAssertEqual(parse("abs(4)")?.joined(separator: " "), "4 abs")
    }

    func testNegativeNumber() throws {
        XCTAssertEqual(parse("-4 + 3")?.joined(separator: " "), "-4 3 +")
    }

    func testPiSpelledOut() throws {
        XCTAssertEqual(parse("pi * 2")?.joined(separator: " "), "pi 2 *")
    }

    func testPiSymbol() throws {
        XCTAssertEqual(parse("2*π")?.joined(separator: " "), "2 π *")
    }
    
    func testMultiSin() throws {
        XCTAssertEqual(parse("sin(x) + 2")?.joined(separator: " "), "x sin 2 +")
    }
    
    func testMultiOtherLog() throws {
        XCTAssertEqual(parse("log5(2) + 3")?.joined(separator: " "), "2 log5 3 +")
    }
    
    func testMinusMulti() throws {
        XCTAssertEqual(parse("10x-2")?.joined(separator: " "), "10 x * 2 -")
    }

    func testExponents() throws {
        XCTAssertEqual(parse("2^5")?.joined(separator: " "), "2 5 ^")
    }

    func testExponentOOO() throws {
        XCTAssertEqual(parse("(5*pi)^5 + 3 / 5")?.joined(separator: " "), "5 pi * 5 ^ 3 5 / +")
    }

    func testPiCombineWithNumber() throws {
        XCTAssertEqual(parse("2pi")?.joined(separator: " "), "2 pi *")
    }

    func testNaturalLog() throws {
        XCTAssertEqual(parse("ln(5pi)")?.joined(separator: " "), "5 pi * ln")
    }

    func testOtherLog() throws {
        XCTAssertEqual(parse("log5(2)")?.joined(separator: " "), "2 log5")
    }

    func testCubeRoot() throws {
        XCTAssertEqual(parse("cbrt(8)")?.joined(separator: " "), "8 cbrt")
    }

    func testOtherRoot() throws {
        XCTAssertEqual(parse("root4(16)")?.joined(separator: " "), "16 root4")
    }

    func testOtherRootWithSpace() throws {
        XCTAssertEqual(parse("root 4(16)")?.joined(separator: " "), "16 root4")
    }

    func testXVariable() throws {
        XCTAssertEqual(parse("x + 3")?.joined(separator: " "), "x 3 +")
    }

    func testXCombine() throws {
        XCTAssertEqual(parse("3x + 3")?.joined(separator: " "), "3 x * 3 +")
    }
}
