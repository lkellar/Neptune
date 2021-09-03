//
//  Graph.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-12.
//

import SwiftUI
import os

private let graphLogger = Logger(subsystem: "org.lkellar.neptune", category: "graph")

struct Graph: View {
    @State var bounds: Bounds
    @Binding var equations: [Equation]
    @State var points: [Equation: [CGPoint]]
    @State var scaleFactor: Double = 1
    @State var useAnimation = false
    @GestureState var magnifyBy: Double = 1
    @State var zoomingIn: Bool = true
    
    init(equations: Binding<[Equation]>) {
        let startingBounds = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
        _equations = equations
        _points = State.init(initialValue: calcPoints(equations: equations.wrappedValue, bounds: startingBounds))
        bounds = startingBounds
    }
    
    var magnification: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { value, state, transaction in
                state = 1 / value
            }
            .onEnded { value in 
                bounds.scaleFactor *= 1 / value
            }
    }

    var body: some View {
            ZStack {
                CoreGraph(bounds: bounds, scaleFactor: bounds.scaleFactor * magnifyBy, equations: equations, points: points)
                    .animation(.easeInOut(duration: 0.5), value: bounds.scaleFactor)
                    .gesture(magnification)
                    .onChange(of: bounds ) {[bounds] newBounds in
                        print("Old Scale Factor: \(bounds.scaleFactor). New Bounds Scale Factor: \(newBounds.scaleFactor)")
                        // if we're getting smaller, don't calculate new points until after we've zoomed
                        let localZoomingIn = bounds.scaleFactor > newBounds.scaleFactor
                        zoomingIn = bounds.scaleFactor > newBounds.scaleFactor
                        DispatchQueue.main.asyncAfter(deadline: .now() + (bounds.scaleFactor > newBounds.scaleFactor ? 0.5 : 0)) {
                            if (localZoomingIn == zoomingIn) {
                                graphLogger.debug("New Bounds -> Recalculating")
                                points = calcPoints(equations: equations, bounds: newBounds.zoom(by: newBounds.scaleFactor))
                            }
                        }
                    }
                
                #if os(macOS)
                    HStack {
                        Spacer()
                        VStack {
                            BoundIndicator(bounds: $bounds)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 15))
                            Spacer()
                            Button(action: {
                                    scaleFactor = scaleFactor == 0.1 ? 1 : 0.1
                            }, label: {
                                Text("adjust")
                            })
                            ZoomControls(bounds: $bounds, scaleFactor: $scaleFactor, useAnimation: $useAnimation)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 15))
                            MoveControls(bounds: $bounds)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 15))
                        }
                    }
                #endif
        }
    }

    func getSmallBounds(index: CGFloat) -> Bounds {
        let height = CGFloat(2)
        let top = bounds.topLeft.y
        return Bounds(topLeft: CGPoint(x: bounds.topLeft.x, y: top - (index * height)), lowerRight: CGPoint(x: bounds.lowerRight.x, y: top - (height*(index + 1))))
    }

}

struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph(equations: Binding.constant([Equation(value: "x^2-8", color: .blue, strokeWidth: 3)]))
    }
}
