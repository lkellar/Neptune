//
//  ColorTileManager.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-05-29.
//

import SwiftUI

struct ColorTileManager: View {
    @Binding var tileSize: CGFloat

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach((0...(Int(20 / (tileSize / 100)))), id: \.self) { _ in
                LazyHStack(spacing: 0) {
                    ForEach((0...(Int(20 / (tileSize / 100)))), id: \.self) { _ in
                        ColorTile(size: $tileSize)
                    }
                }
            }
        }
    }
}

struct ColorTileManager_Previews: PreviewProvider {
    static var previews: some View {
        NoPreview()
    }
}
