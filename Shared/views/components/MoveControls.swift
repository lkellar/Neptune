//
//  ZoomControls.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-03-16
//

import SwiftUI

struct MoveControls: View {
    @Binding var bounds: Bounds

    @Environment(\.colorScheme) var colorScheme
    var body: some View {
            ZStack {
            RoundedRectangle(cornerRadius: 7.92)
                .fill((colorScheme == .dark ? Color(red: 0.24, green: 0.24, blue: 0.26, opacity: 1.00) : Color(red: 0.88, green: 0.88, blue: 0.88, opacity: 1.00)))

            VStack {
                VStack {
                    // Make this a proper button
                    Image(systemName: "arrow.up")
                        .font(.system(size: 24))
                        .onTapGesture {
                            move(y: 1)
                        }
                }.frame(width: 40, height: 24)

                Spacer()
                Divider()
                Spacer()

                VStack {
                    Image(systemName: "arrow.down")
                        .font(.system(size: 24))
                        .onTapGesture {
                            move(y: -1)
                        }
                }.frame(width: 40, height: 24)

            }.frame(width: 40, height: 60)

        }.frame(width: 40, height: 80)
    }

    func move(y: CGFloat) {
        // divide by two for both sides
        bounds = Bounds(topLeft: CGPoint(x: bounds.topLeft.x, y: bounds.topLeft.y + y), lowerRight: CGPoint(x: bounds.lowerRight.x, y: bounds.lowerRight.y + y))
    }
}

struct MoveControls_Previews: PreviewProvider {
    static var previews: some View {
        MoveControls(bounds: Binding.constant(Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))))
    }
}
