//
//  Equation.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-22.
//

import Foundation
import SwiftUI

struct Equation: Hashable, Equatable {
    // the actual text of the equation
    let value: String
    let color: Color
    let strokeWidth: CGFloat
}
