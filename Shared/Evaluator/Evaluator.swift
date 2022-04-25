//
//  Evaluator.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-02-21.
//

import Foundation
import os

private let logger = Logger(subsystem: "org.lkellar.neptune", category: "evaluator")

func evaluate(_ equation: [String], variables: [String: Double] = [:]) -> Double? {
    var stack: [Double] = []
    for token in equation {
        if let variable = variables[token] {
            stack.append(variable)
        } else if let number = token.double {
            stack.append(number)
        } else if numbers.contains(token) {
            switch token {
            case "π", "pi":
                stack.append(Double.pi)
            case "e":
                stack.append(exp(1))
            default:
                logger.error("\(token) is not defined!")
                return nil
            }
        } else if operators.keys.contains(token) {
            switch token {
            case "+":
                // pop the bottom of the stack and add it to the new bottom of the stack
                guard let first = stack.popLast(), let second = stack.popLast() else {
                    logger.error("Popped from stack but got nil")
                    return nil
                }
                stack.append(first + second)
            case "-":
                // pop the bottom of the stack and minus it from the new bottom of the stack
                guard let minusor = stack.popLast(), let minivend = stack.popLast() else {
                    logger.error("Popped from stack but got nil")
                    return nil
                }
                stack.append(minivend - minusor)
            case "*":
                guard let first = stack.popLast(), let second = stack.popLast() else {
                    logger.error("Popped from stack but got nil")
                    return nil
                }
                stack.append(first * second)
            case "/":
                guard let divisor = stack.popLast(), let dividend = stack.popLast() else {
                    logger.error("Popped from stack but got nil")
                    return nil
                }
                stack.append(dividend / divisor)
            case "^":
                guard let power = stack.popLast(), let target = stack.popLast() else {
                    logger.error("Popped from stack but got nil")
                    return nil
                }
                stack.append(pow(target, power))
            default:
                logger.error("\(token) has not been implemented as an operator")
                return nil
            }
        } else if functions.contains(token) {
            guard let value = stack.popLast() else {
                logger.error("A value was popped from stack and turned out to be nil")
                return nil
            }
            switch token {
            case "sin":
                stack.append(sin(value))
            case "cos":
                stack.append(cos(value))
            case "tan":
                stack.append(tan(value))
            case "asin":
                stack.append(asin(value))
            case "acos":
                stack.append(acos(value))
            case "atan":
                stack.append(atan(value))
            case "sqrt":
                stack.append(sqrt(value))
            case "cbrt":
                stack.append(cbrt(value))
            case "abs":
                stack.append(abs(value))
            case "ln":
                stack.append(log(value))
            default:
                logger.error("\(token) has not been implemented as a function")
                return nil
            }
        } else {
            var found = false
            for prefix in prefixFunctions {
                if token.starts(with: prefix) {
                    found = true
                    switch prefix {
                    case "log":
                        // grab the 5 from log5 for example, do a log with custom base
                        guard let value = stack.popLast(), let base = token.replacingOccurrences(of: prefix, with: "").double else {
                            return nil
                        }
                        stack.append(logC(value, forBase: base))
                    case "root":
                        // take root3(125) -> 125^1/3 -> 5
                        guard let root = token.replacingOccurrences(of: prefix, with: "").double else {
                            logger.error("\(token) is not in correct format for root")
                            return nil
                        }
                        guard let target = stack.popLast() else {
                            logger.error("Tried to pop stack for root but got nil")
                            return nil
                        }
                        stack.append(pow(target, (1/root)))
                    default:
                        logger.error("\(token) has not been implemented as a prefixfunction")
                        return nil
                    }
                    break
                }
            }
            if !found {
                logger.error("\(token) is not recognized")
                return nil
            }
        }
    }

    guard stack.first == stack.last else {
        logger.error("Stack length is \(stack.count) when it should be 1")
        return nil
    }

    // should be the only item in list
    return stack.last
}

// swiftlint:enable cyclomatic_complexity
