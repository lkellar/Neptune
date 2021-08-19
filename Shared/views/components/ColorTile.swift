//
//  ColorTile.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-04-16.
//

import SwiftUI

let allColors = [Color.random, Color.random, Color.random, Color.random, Color.random, Color.random, Color.random, Color.random, Color.random, Color.random]

struct ColorTile: View {
    @Binding var size: CGFloat

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach((0...(Int(20 / (size / 100)))), id: \.self) { bigIndex in
                LazyHStack(spacing: 0) {
                    ForEach((0...(Int(20 / (size / 100)))), id: \.self) { index in
                Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(allColors[(bigIndex + index) % allColors.count])
                    .frame(width: size, height: size)
            }
        }
                }
        }
    }
}

struct ColorTile_Previews: PreviewProvider {
    static var previews: some View {
        ColorTile(size: Binding.constant(100))
    }
}
