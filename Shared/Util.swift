//
//  Util.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-01-15.
//

import Foundation
import SwiftUI
import os

private let logger = Logger(subsystem: "org.lkellar.neptune", category: "util")

// Convert a xy coordinate from the calculator to the actual graph
func coordToGeo(size: CGSize, coord: CGPoint, bounds: Bounds) -> CGPoint {
    let x = ((coord.x - bounds.topLeft.x) / (bounds.lowerRight.x - bounds.topLeft.x)) * size.width
    let y = ((coord.y - bounds.topLeft.y) / (bounds.lowerRight.y - bounds.topLeft.y)) * size.height
    return CGPoint(x: x, y: y)
}

func axisToGeo(size: CGSize, coord: CGFloat, bounds: Bounds, horizontal: Bool) -> CGFloat {
    if horizontal {
        return ((coord - bounds.topLeft.x) / (bounds.lowerRight.x - bounds.topLeft.x)) * size.width
    }
    return ((coord - bounds.topLeft.y) / (bounds.lowerRight.y - bounds.topLeft.y)) * size.height
}

func lengthToGeo(size: CGSize, length: CGFloat, bounds: Bounds, horizontal: Bool) -> CGFloat {
    if horizontal {
        return length / (bounds.lowerRight.x - bounds.topLeft.x) * size.width
    }
    return length / (bounds.topLeft.y - bounds.lowerRight.y) * size.height
}

func dragToBounds(drag: CGSize, geo: GeometryProxy, bounds: Bounds) -> CGSize {
    let width = ((bounds.lowerRight.x - bounds.topLeft.x) / geo.size.width) * drag.width
    let height = ((bounds.topLeft.y - bounds.lowerRight.y) / geo.size.height) * drag.height
    return CGSize(width: width, height: height)
}

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}

// pulled from stackoverflow
extension StringProtocol {
    var double: Double? { Double(self) }
    var float: Float? { Float(self) }
    var integer: Int? { Int(self) }

    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>) -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>) -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}

// pulled from a github gist
extension Color {
    /// Return a random color
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }

    static let darkSystemGray4 = Color(red: 0.227, green: 0.227, blue: 0.23, opacity: 1.00)
    static let lightSystemGray4 = Color(red: 0.819, green: 0.819, blue: 0.83, opacity: 1.00)
    static let darkSystemGray3 = Color(red: 0.282, green: 0.282, blue: 0.29, opacity: 1.00)
    static let lightSystemGray3 = Color(red: 0.78, green: 0.78, blue: 0.8, opacity: 1.00)
}

// also pulled from stackoverflow; custom log function
func logC(_ val: Double, forBase base: Double) -> Double {
    return log(val)/log(base)
}

// nested scroll view fixing from https://stackoverflow.com/questions/64920744/swiftui-nested-scrollviews-problem-on-macos

// we need this workaround only for macOS
#if os(macOS)

// this is the NSView that implements proper `wantsForwardedScrollEvents` method
final class VerticalScrollingFixHostingView<Content>: NSHostingView<Content> where Content: View {

  override func wantsForwardedScrollEvents(for axis: NSEvent.GestureAxis) -> Bool {
    return axis == .vertical
  }
}

// this is the SwiftUI wrapper for our NSView
struct VerticalScrollingFixViewRepresentable<Content>: NSViewRepresentable where Content: View {

  let content: Content

  func makeNSView(context: Context) -> NSHostingView<Content> {
    return VerticalScrollingFixHostingView<Content>(rootView: content)
  }

  func updateNSView(_ nsView: NSHostingView<Content>, context: Context) {}

}

// this is the SwiftUI wrapper that makes it easy to insert the view
// into the existing SwiftUI view builders structure
struct VerticalScrollingFixWrapper<Content>: View where Content: View {

  let content: () -> Content

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }

  var body: some View {
    VerticalScrollingFixViewRepresentable(content: self.content())
  }
}
#endif

// just a helper to make using nicer by keeping #if os(macOS) in one place
extension View {
  @ViewBuilder func macosScrollingBugFix() -> some View {
    #if os(macOS)
    VerticalScrollingFixWrapper { self }
    #else
    self
    #endif
  }
}

struct ZoomButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .foregroundColor(.primary)
            .background(!configuration.isPressed ? colorScheme == .dark ? Color.darkSystemGray4 : Color.lightSystemGray4 : colorScheme == .dark ? Color.darkSystemGray3 : Color.lightSystemGray3)
            .cornerRadius(7.92)
    }
}


let originalBounds = Bounds(topLeft: CGPoint(x: -10, y: 10), lowerRight: CGPoint(x: 10, y: -10))


func calcPoints(equations: [Equation], bounds: Bounds) -> [Equation: [CGPoint]] {
    var localPoints: [Equation: [CGPoint]] = [:]
    for equation in equations {
        localPoints[equation] = calculate(equation: equation.value, start: bounds.topLeft.x, end: bounds.lowerRight.x, step: (bounds.lowerRight.x - bounds.topLeft.x) / 1000)
    }
    return localPoints
}

func calcOnePoints(equation: Equation, bounds: Bounds) -> [CGPoint] {
    return calculate(equation: equation.value, start: bounds.topLeft.x, end: bounds.lowerRight.x, step: (bounds.lowerRight.x - bounds.topLeft.x) / 1000)
}
