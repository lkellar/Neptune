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
            Axes(bounds: bounds, scaleFactor: scaleFactor)
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
    
    var animatableData: Double {
        get { return scaleFactor }
        set { scaleFactor = newValue }
    }
}

struct CoreGraph_Previews: PreviewProvider {
    static var previews: some View {
        NoPreview()
    }
}
