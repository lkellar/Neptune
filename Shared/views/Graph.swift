//
//  Graph.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-12.
//

import SwiftUI
import os

private let graphLogger = Logger(subsystem: "org.lkellar.neptune", category: "graph")

var cache: [String: [CGPoint]] = [:]

let megaEquations = [
    Equation(value: "x^3", color: .purple, strokeWidth: 5),
    Equation(value: "x^2 - 5", color: .pink, strokeWidth: 5)]

let megaPoints = calcPoints(equations: megaEquations, bounds: originalBounds)

let animationSteps = [
    Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10)),
    Bounds(topLeft: CGPoint(x: -9, y: 9), lowerRight: CGPoint(x: 9, y: -9)),
    Bounds(topLeft: CGPoint(x: -8, y: 8), lowerRight: CGPoint(x: 8, y: -8)),
    Bounds(topLeft: CGPoint(x: -7, y: 7), lowerRight: CGPoint(x: 7, y: -7)),
    Bounds(topLeft: CGPoint(x: -6, y: 6), lowerRight: CGPoint(x: 6, y: -6)),
    Bounds(topLeft: CGPoint(x: -5, y: 5), lowerRight: CGPoint(x: 5, y: -5))
]

let betterSteps = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]


struct Graph: View {
    @State var bounds = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
    @Binding var equations: [Equation]
    @State var scaleFactor: Double = 1
    @State var useAnimation = false
    @GestureState var magnifyBy: Double = 1

    @State var viewState = CGSize.zero
    @State var tileSize: CGFloat = 100
    @Namespace var topID
    @Namespace var bottomID
    
    var magnification: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { value, state, transaction in
                state = 1 / value
            }
            .onEnded { value in 
                bounds.scale(by: (1 / value))
            }
    }

    // make sure to add cache purging
    var body: some View {
       //if #available(macOS 12.0, iOS 15, *) {
            ZStack {
                CoreGraph(bounds: bounds, scaleFactor: scaleFactor * magnifyBy, equations: megaEquations, points: megaPoints)
                    //.drawingGroup()
                    .animation(.easeInOut(duration: 1), value: useAnimation)
                    .gesture(magnification)
                
                #if os(macOS)
                    HStack {
                        Spacer()
                        VStack {
                            BoundIndicator(bounds: $bounds, tileSize: $tileSize)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 15))
                            Spacer()
                            Button(action: {
                                    scaleFactor = scaleFactor == 0.1 ? 1 : 0.1
                                print("yolo")
                                //}
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
                /*.gesture(DragGesture()
                        // THERE NEEDS TO BE A MEGA INVISIBLE RECTANGLE
                        .onChanged {value in

                            let coordShift = dragToBounds(drag: value.translation, geo: geo, bounds: bounds)
                            let xDiff = coordShift.width - viewState.width
                            let yDiff = coordShift.height - viewState.height
                            viewState = coordShift
                            bounds = Bounds(topLeft: CGPoint(x: bounds.topLeft.x - xDiff, y: bounds.topLeft.y + yDiff), lowerRight: CGPoint(x: bounds.lowerRight.x - xDiff, y: bounds.lowerRight.y + yDiff))
                        }
                        .onEnded { value in
                            viewState = .zero
                            bounds = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))
                        })*/
        }
        /*} else {
            // Fallback on earlier versions
            Text("upgrade your version coward")
        }*/
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
