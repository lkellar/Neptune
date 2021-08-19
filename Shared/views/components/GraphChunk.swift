//
//  GraphChunk.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-03-19.
//

import SwiftUI

struct GraphChunk: View {
    var fullBounds: Bounds
    var bounds: Bounds
    @Binding var equations: [Equation]
    var geo: GeometryProxy
    var body: some View {
            ZStack {
                // Horizontal Lines
                /*ForEach(Array(Axes(lowerBound: bounds.lowerRight.y, upperBound: bounds.topLeft.y), id: \.self) {index in
                    /*if significantLine(index: index, horizontal: true) {
                        GraphLabel(bounds: bounds, text: Int(index).description, geo: geo, point: CGPoint(x: 0.25, y: 0.5 + index))
                    }*/
                    Line(start: CGPoint(x: bounds.topLeft.x, y: index), end: CGPoint(x: bounds.lowerRight.x, y: index), geo: geo, bounds: fullBounds, strokeLength: index == 0 ? 4 : 1)
                }

                // Vertical Lines
                ForEach(Array(Axes(lowerBound: bounds.topLeft.x, upperBound: bounds.lowerRight.x), id: \.self) {index in
                    /*if significantLine(index: index, horizontal: false) {
                        GraphLabel(bounds: bounds, text: Int(index).description, geo: geo, point: CGPoint(x: index + 0.25, y: 0.5))
                    }*/
                    Line(start: CGPoint(x: index, y: bounds.topLeft.y), end: CGPoint(x: index, y: bounds.lowerRight.y), geo: geo, bounds: fullBounds, strokeLength: index == 0 ? 4 : 1)
                }
                /*
                
                //GraphLabel(topLeft: $topLeft, lowerRight: $lowerRight, text: "0", geo: geo, point: CGPoint(x: 0.25, y: 0.5))
                
                ForEach(equations, id: \.self) {equation in
                    // Example Line
                    ComplexLine(bounds: bounds, equation: equation, geo: geo)
                }*/
            }

            .background(Color.random)*/
            Text("deprecated")
            }
    }

    /*func significantLine(index: CGFloat, horizontal: Bool) -> Bool {
        if (index == 0) {
            return true
        } else if (index.truncatingRemainder(dividingBy: 5) == 0) {
            if horizontal && (abs(index / (bounds.topLeft.x - bounds.lowerRight.x)) >= 0.2) {
                return true
            } else if !horizontal && (abs(index / (bounds.lowerRight.y - bounds.topLeft.y)) >= 0.2) {
                return true
            }
        }
        return false
    }*/
}

struct GraphChunk_Previews: PreviewProvider {
    static var previews: some View {
        Text("No PReview")
    }
}
