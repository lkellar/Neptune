//
//  ZoomControls.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-02-24.
//

import SwiftUI

struct ZoomControls: View {
    @Binding var bounds: Bounds
    @Binding var scaleFactor: Double
    @Binding var useAnimation: Bool
    let originalBounds = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
    
    // TODO ADD COMMON DEADLINE
    
    func zoomInAction() {
        useAnimation.toggle()
        bounds.scaleFactor /= 2
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            bounds.scale(by: 0.5)
            scaleFactor *= 2
        }*/
    }
    
    func zoomOutAction() {
        useAnimation.toggle()
        bounds.scaleFactor *= 2
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            bounds.scale(by: 2)
            scaleFactor /= 2
        }*/
    }

    @Environment(\.colorScheme) var colorScheme
    var body: some View {
            ZStack {

            RoundedRectangle(cornerRadius: 7.92)
                .fill((colorScheme == .dark ? Color(red: 0.24, green: 0.24, blue: 0.26, opacity: 1.00) : Color(red: 0.88, green: 0.88, blue: 0.88, opacity: 1.00)))

            VStack {
                ZStack {
                    Button {
                        zoomInAction()
                    } label: {}
                    .padding(0)
                    .opacity(0)
                    .frame(width: 0, height: 0)
                    .keyboardShortcut("=", modifiers: [])
                    // Make this a proper button
                    Button {
                        zoomInAction()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                    }
                    .buttonStyle(ZoomButtonStyle())
                }.frame(width: 40, height: 24)

                Spacer()
                Divider()
                Spacer()

                ZStack {
                    Button {
                        zoomOutAction()
                    } label: {}
                    .padding(0)
                    .opacity(0)
                    .frame(width: 0, height: 0)
                    .keyboardShortcut("-", modifiers: [])
                    // Make this a proper button
                    Button {
                        zoomOutAction()
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 24))
                    }
                    .buttonStyle(ZoomButtonStyle())
                }.frame(width: 40, height: 24)

            }.frame(width: 40, height: 60)

        }.frame(width: 40, height: 80)
    }
    

}

struct ZoomControls_Previews: PreviewProvider {
    static var previews: some View {
        NoPreview()
    }
}
