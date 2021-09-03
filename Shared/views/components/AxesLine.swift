//
//  AxesLine.swift
//  Neptune
//
//  Created by Lucas Kellar on 9/1/21.
//

import SwiftUI

struct AxesLine: Shape {
    let horizontal: Bool
    var bounds: Bounds
    var scaleFactor: Double = 1
        
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let sizedBounds = bounds.zoom(by: scaleFactor)
        
        let axesInfo = Axes.generateAxesInfo(lowerBound: horizontal ? sizedBounds.topLeft.x : sizedBounds.lowerRight.y, upperBound: horizontal ? sizedBounds.lowerRight.x : sizedBounds.topLeft.y)
        let bars = Array(stride(from: axesInfo.lowerBound, to: axesInfo.upperBound, by: axesInfo.step))
        let points = bars.map {bar in
            [CGPoint(x: horizontal ? sizedBounds.topLeft.x : bar, y: horizontal ? bar : sizedBounds.lowerRight.y), CGPoint(x: horizontal ? sizedBounds.lowerRight.x : bar, y: horizontal ? bar : sizedBounds.topLeft.y)].map { point in
            coordToGeo(size: rect.size, coord: point, bounds: sizedBounds)
            }
        }
        
        for point in points {
            path.move(to: point[0])
            path.addLine(to: point[1])
        }
        return path;
    }
    
    var animatableData: Double {
        get { return scaleFactor }
        set { scaleFactor = newValue }
    }
}

struct AxesLine_Previews: PreviewProvider {
    static var previews: some View {
        NoPreview()
    }
}
