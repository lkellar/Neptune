//
//  Axes.swift
//  Neptune
//
//  Created by Lucas Kellar on 8/30/21.
//

import SwiftUI

struct AxesInfo {
    let upperBound: CGFloat
    let lowerBound: CGFloat
    let step: CGFloat
    var midpoint: CGFloat {
        return (upperBound - lowerBound) / 2 + lowerBound
    }
}

struct Axes: View {
    var bounds: Bounds
    var scaleFactor: Double

    var body: some View {
        ZStack {
                AxesLine(horizontal: false, bounds: bounds, scaleFactor: scaleFactor)
                    .stroke(Color.primary, lineWidth: 1.0)
                AxesLine(horizontal: true, bounds: bounds, scaleFactor: scaleFactor)
                    .stroke(Color.primary, lineWidth: 1.0)
        }.drawingGroup()
    }
    
    static func generateAxesInfo(lowerBound rawLowerBound: CGFloat, upperBound rawUpperBound: CGFloat) -> AxesInfo {
        let range: CGFloat = rawUpperBound - rawLowerBound
        var step = CGFloat(pow(10, logC(range, forBase: 10).rounded(.down)))
        
        if (range / step < 2.5) {
            step /= 10
        }
        
        let lowerBound = rawLowerBound - rawLowerBound.truncatingRemainder(dividingBy: step)
        let upperBound = rawUpperBound - rawUpperBound.truncatingRemainder(dividingBy: step) + step
        
        return AxesInfo(upperBound: upperBound, lowerBound: lowerBound, step: step)
    }
    
    var animatableData: Double {
        get { return scaleFactor }
        set { scaleFactor = newValue }
    }
    

}

struct Axes_Previews: PreviewProvider {
    static var previews: some View {
        NoPreview()
    }
}
