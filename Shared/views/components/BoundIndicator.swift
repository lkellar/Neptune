//
//  BoundIndicator.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-03-16.
//

import SwiftUI

struct BoundIndicator: View {
    @Binding var bounds: Bounds
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7.92)
                .fill((colorScheme == .dark ? Color(red: 0.24, green: 0.24, blue: 0.26, opacity: 1.00) : Color(red: 0.88, green: 0.88, blue: 0.88, opacity: 1.00)))
            VStack {
                Text("Top Left: (\(Int(bounds.topLeft.x)), \(Int(bounds.topLeft.y)))")
                Text("Lower Right: (\(Int(bounds.lowerRight.x)), \(Int(bounds.lowerRight.y)))")
            }
        }.frame(width: 160, height: 40)
    }
}

struct BoundIndicator_Previews: PreviewProvider {
    static var previews: some View {
        BoundIndicator(bounds: Binding.constant(Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))))
    }
}
