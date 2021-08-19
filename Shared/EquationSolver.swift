//
//  EquationSolver.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-03-10.
//

import Foundation
import Combine
import SwiftUI

class EquationSolver: ObservableObject {
    var equation: Equation

    init(equation: Equation) {
        print("init")
        self.equation = equation
    }
    @Published private(set) var points: [CGPoint] = []

    func solve(topLeft: CGPoint, lowerRight: CGPoint, step: CGFloat) {
        print("yo")
        points = calculate(equation: equation.value, start: topLeft.x, end: lowerRight.x, step: step)
    }
}
