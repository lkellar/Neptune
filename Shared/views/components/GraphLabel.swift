//
//  GraphLabel.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-27.
//

import SwiftUI

struct GraphLabel: View {
    var bounds: Bounds

    var text: String
    var geo: GeometryProxy
    var point: CGPoint

    var body: some View {
        Text(text)
            .font(.system(.body, design: .rounded))
            .bold()
            .position(coordToGeo(size: geo.size, coord: point, bounds: bounds))
    }
}

struct GraphLabel_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {geo in
            GraphLabel(bounds: Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10)), text: "Hey", geo: geo, point: CGPoint(x: 0, y: 0))
        }
    }
}
