//
//  Parser.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-27.
//

import Foundation
import os

private let logger = Logger(subsystem: "org.lkellar.neptune", category: "parser")

func splitToTokens(_ input: String) -> [String]? {
    let equation = input.replacingOccurrences(of: " ", with: "")
    var tokens = [String]()

    var index = 0

    while index < equation.count {
        var value = String(equation[index])
        // if the value is a negative sign and last token WAS NOT a number or a closing parantheses
        let negative = tokens.last?.double == nil && tokens.last != ")" && value == "-"
        // if the value is a valid number or it's a negative sign and the next value is a number
        if numbers.contains(value) || (equation.count > index + 1 && negative && numbers.contains(String(equation[index + 1]))) {
            // if we're looking at a negative sign, grab the next value (a number) and carry on
            if negative {
                index += 1
                value = "-" + String(equation[index])
            }
            // while the next char is a number or the next char is a decimal and the following char is a number
            while index + 1 < equation.count &&
                    (numbers.contains(String(equation[index + 1])) &&
                        (value + String(equation[index + 1])).double != nil
                    ) ||
                    (index + 2 < equation.count &&
                        String(equation[index + 1]) == "." &&
                        numbers.contains(String(equation[index + 2])) &&
                        (value + String(equation[index + 1]) + String(equation[index + 2])).double != nil
                    ) {
                value += String(equation[index + 1])
                index += 1
            }

            tokens.append(value)
        } else if equation.count > index + 1 && numbers.contains(String(equation[index ... index + 1])) {
            // if a two letter number is present (such as pi), grab it and increase index
            tokens.append(String(equation[index ... index + 1]))
            index += 1
        } else if operators.keys.contains(value) || value == "(" || value == ")" {
            // if the value is a single char operator
            tokens.append(value)
        } else {
            var found = false
            for function in (functions + prefixFunctions) {
                // if the function is 3 chars long, see if the next 3 chars are equal to the function
                if equation.count >= index + function.count && function == String(equation[index ... index + (function.count - 1)]) {
                    tokens.append(String(equation[index ... index + (function.count - 1)]))
                    index += (function.count - 1)
                    found = true
                    break
                }
            }
            if !found {
                // probably should return an error message at some point
                logger.error("Equation \(equation, privacy: .public) failed with unknown value \(value, privacy: .public)")
                return nil
            }

        }

        index += 1
    }
    if tokens.count == 0 {
        return []
    }
    

    // section to add multiplication symbols between two values with no operator

    var freshList = [tokens[0]]
    // tracker to determine if last token is a value or function/operator or if it's a parantheses (essentially making it a value)
    var last = tokens[0]
    for token in tokens.suffix(from: 1) {
        let lastIsValue = numbers.contains(last) || last == ")" || last.double != nil
        let currentIsValue = numbers.contains(token) || token == "(" || token.double != nil

        // if last is prefix function and current is number (e.g. log 5), pass it as one token
        if prefixFunctions.contains(last) && (numbers.contains(token) || token.double != nil) {
            // remove the prefix that was just added to the lsit
            freshList.removeLast()
            freshList.append(last + token)
            continue
        }
        // if the last and current value is an operator, add an multiplication symbol
        if lastIsValue && currentIsValue {
            freshList.append("*")
        }
        freshList.append(token)
        last = token
    }

    return freshList
}

func parse(_ input: String) -> [String]? {
    var stack = [String]()
    var output = [String]()

    guard let tokens = splitToTokens(input) else {
        logger.info("No tokens returned for \(input, privacy: .public)")
        return nil
    }

    // implementation of shunting-yard algorithim
    for token in tokens {
        // if char is a valid number
        if token.double != nil || numbers.contains(token) {
            // if this is a number and the last token was also a number, add a multiply
            // add number to output
            output.append(token)
        } else if functions.contains(token) {
            // apparently, if token is function, push it onto stack
            stack.append(token)
        } else if operators.keys.contains(token) { // if the character is a valid operator
            if stack.count == 0 {
                // if stack is empty, add our operator to the stack

                stack.append(token)
            } else {
                while stack.count > 0 {
                    guard let topOp = stack.last else {
                        logger.error("Despite stack having contents, stack.last is nil")
                        return nil
                    }
                    // if first item in stack has higher precendence (or is equal), pop it
                    if operators[topOp] ?? -1 >= operators[token] ?? -1  && topOp != "(" {
                        output.append(stack.popLast()!)
                        if stack.count == 0 {
                            // if stack is now empty, add our operator to the stack
                            stack.append(token)
                            break
                        }
                    } else {
                        // if not, add it to the stack and break out of the while
                        stack.append(token)
                        break
                    }
                }
            }
        } else if token == "(" {
            stack.append(token)
        } else if token == ")" {
            var topOp = stack.popLast()
            while topOp != "(" {
                guard topOp != nil else {
                    logger.error("Left parantheses not found when trying to close right parantheses")
                    return nil
                }

                output.append(topOp!)
                topOp = stack.popLast()
            }
            topOp = stack.last
            if let topOp = topOp {
                if functions.contains(topOp) {
                    output.append(stack.popLast()!)
                } else {
                    for prefixFunction in prefixFunctions {
                        if topOp.starts(with: prefixFunction) {
                            // if a function, add to stack
                            output.append(stack.popLast()!)
                        }
                    }
                }
            }

        } else {
            for prefixFunction in prefixFunctions {
                if token.starts(with: prefixFunction) {
                    // if a function, add to stack
                    stack.append(token)
                }
            }
        }
    }

    // TODO REPLACE UNKNOWNS WITH LOGS AND ERROS
    while stack.count > 0 {
        guard let topOp = stack.popLast() else {
            logger.error("Despite stack having contents, stack.last is nil")
            return nil
        }
        guard topOp != "(" || topOp != ")" else {
            logger.error("Found unmatched parantheses when emptying stack at end of parsing. Specifically found: \(topOp, privacy: .public)")
            return nil
        }

        output.append(topOp)

    }

    return output
}
