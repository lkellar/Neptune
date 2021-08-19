//
//  CoreGraph.swift
//  Neptune
//
//  Created by Lucas Kellar on 7/28/21.
//

import SwiftUI
struct CoreGraph: View, Equatable {
    var bounds: Bounds
    var scaleFactor: Double
    var equations: [Equation]
    var points: [Equation: [CGPoint]]
    
    var body: some View {
        //Canvas { context, size in
        ZStack {
            ZStack {
                ForEach(generateAxes(lowerBound: bounds.topLeft.x, upperBound: bounds.lowerRight.x), id:\.self) { bar in
                    Line(points: [CGPoint(x: bar.pos, y: bounds.lowerRight.y), CGPoint(x: bar.pos, y: bounds.topLeft.y)], bounds: bounds, scaleFactor: scaleFactor)
                        .stroke(Color.primary, lineWidth: bar.pos == 0 ? 3.0 : 1.0)
                }
                ForEach(generateAxes(lowerBound: bounds.lowerRight.y, upperBound: bounds.topLeft.y), id:\.self) { bar in
                    Line(points: [CGPoint(x: bounds.lowerRight.x, y: bar.pos), CGPoint(x: bounds.topLeft.x, y: bar.pos)], bounds: bounds, scaleFactor: scaleFactor)
                        .stroke(Color.primary, lineWidth: bar.pos == 0 ? 3.0 : 1.0)
                }
            }.drawingGroup()
            
            ForEach(equations, id:\.self) { equation in
                if let localPoints = points[equation] {
                    Line(points: localPoints, bounds: bounds, scaleFactor: scaleFactor)
                        .stroke(equation.color, lineWidth: 5)
                }
            }
                
            /*for equation in equations {
                if let localPoints = points[equation] {
                    var path = Path()
                    path.addLines(localPoints.map { point in
                        coordToGeo(size: size, coord: point, bounds: sizedBounds)
                    })
                context.stroke(path, with: .color(equation.color), lineWidth: 5.0)
                }
            }*/
        }
    }
}

struct CoreGraph_Previews: PreviewProvider {
    static var previews: some View {
        NoPreview()
    }
}
