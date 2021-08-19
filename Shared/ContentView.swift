//
//  ContentView.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*Text(calculate(equation: "x+3", start: 0, end: 5, step: 1).debugDescription)
        */
        Graph(equations: Binding.constant([
            // Equation(value: "x^2-8", color: .blue, strokeWidth: 3),
            // Equation(value: "sin(x)", color: .red, strokeWidth: 3),
            Equation(value: "x^3", color: .purple, strokeWidth: 5),
            Equation(value: "x^2 - 5", color: .pink, strokeWidth: 5)
            // Equation(value: "abs(x+2)", color: .green, strokeWidth: 3),
            // Equation(value: "x^3", color: .orange, strokeWidth: 4),
            // Equation(value: "x-2", color: .green, strokeWidth: 4),
            // Equation(value: "-(1/x^2)", color: .blue, strokeWidth: 4),
              //                              Equation(value: "2/x^3", color: .red, strokeWidth: 4)
            // Equation(value: "exp(x)", color: .green, strokeWidth: 4)
        ]))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
