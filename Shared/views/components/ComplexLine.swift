//
//  ComplexLine.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-27.
//

import SwiftUI
import os

private let complexLineLogger = Logger(subsystem: "org.lkellar.neptune", category: "complexline")

struct ComplexLine: View {
    var bounds: Bounds

    var equation: Equation
    var geo: GeometryProxy
    @State var points: [CGPoint]

    init(bounds: Bounds, equation: Equation, geo: GeometryProxy) {
        self.bounds = bounds
        self.equation = equation
        self.geo = geo
        _points = State.init(initialValue: calculate(equation: equation.value, start: bounds.topLeft.x, end: bounds.lowerRight.x, step: (bounds.lowerRight.x - bounds.topLeft.x) / 1000))
    }

    var body: some View {
            Path { path in
                if points.count > 1 {

                // start path at first point
                    path.move(to: coordToGeo(size: geo.size, coord: points.first!, bounds: bounds))
                for (index, point) in points.dropFirst().dropLast().enumerated() {
                    // no need to subtract because of the shifting
                    let last = points[index]
                    let next = points[index+2]

                    // calculate rate of change from point from before and point from next. compare
                    let lastDerivative = (point.y - last.y) / (point.x - last.x)
                    let nextDerivative = (next.y - point.y) / (next.x - point.x)
                    let diff = nextDerivative - lastDerivative
                    if abs(diff) > 1000 {
                        print("weird one at \(point), it;s \(diff)")
                        path.move(to: coordToGeo(size: geo.size, coord: point, bounds: bounds))
                    } else {
                        path.addLine(to: coordToGeo(size: geo.size, coord: point, bounds: bounds))
                    }
                }
                    path.addLine(to: coordToGeo(size: geo.size, coord: points.last!, bounds: bounds))
                }

                // path.addLines(mappedPoints)
            }
            .stroke(style: StrokeStyle(lineWidth: equation.strokeWidth))
            .fill(equation.color)
    }
}

struct ComplexLine_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {geo in
            ComplexLine(bounds: Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10)), equation: Equation(value: "x", color: .green, strokeWidth: 4), geo: geo)
        }
    }
}
