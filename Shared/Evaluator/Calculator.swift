//
//  Calculator.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-02-24.
//

import Foundation
import os
import SwiftUI

private let logger = Logger(subsystem: "org.lkellar.neptune", category: "calculator")

var parsedCache: [String: [String]] = [:]

func calculate(equation: String, start: CGFloat, end: CGFloat, step: CGFloat) -> [CGPoint] {
    var results = [CGFloat: CGFloat]()

    if parsedCache[equation] == nil {
        guard let parsedEquation = parse(equation) else {
            logger.error("\(equation) returned nil after parsing")
            // TODO this needs to be a proper error
            return []
        }
        parsedCache[equation] = parsedEquation
    }

    guard let parsedEquation = parsedCache[equation] else {
        logger.error("\(equation) was not found in cache despite passing cache check")
        return []
    }

    for index in stride(from: start, to: end, by: step) {
        guard let result = evaluate(parsedEquation, variables: ["x": Double(index)]) else {
            // we still need undefined bits
            continue
        }

        results[index] = CGFloat(result)
    }

    let keys = results.keys.sorted()

    let points: [CGPoint] = keys.map {
        CGPoint(x: $0, y: results[$0]!)
    }

    return points
}
