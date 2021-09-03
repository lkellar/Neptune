//
//  Line.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-13.
//

import SwiftUI

struct Line: Shape {
    let points: [CGPoint]
    var bounds: Bounds
    var scaleFactor: Double = 1
        
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let sizedBounds = bounds.zoom(by: scaleFactor)
        let mappedPoints = points.map { point in
            coordToGeo(size: rect.size, coord: point, bounds: sizedBounds)
        }
        
        path.addLines(mappedPoints);
        return path;
    }
    
    var animatableData: Double {
        get { return scaleFactor }
        set { scaleFactor = newValue }
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        NoPreview()
    }
}
