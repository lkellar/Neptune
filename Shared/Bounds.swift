//
//  Bounds.swift
//  Neptune
//
//  Created by Lucas Kellar on 2021-03-10.
//

import Foundation
import SwiftUI

struct Bounds: Equatable {
    let topLeft: CGPoint
    let lowerRight: CGPoint
    var scaleFactor: Double = 1
    
    init(topLeft: CGPoint, lowerRight: CGPoint) {
        self.topLeft = topLeft
        self.lowerRight = lowerRight
    }
    
    
    func lowerRightXGeo(size: CGSize) -> CGFloat {
        return axisToGeo(size: size, coord: self.lowerRight.x, bounds: self, horizontal: true)
    }
    func lowerRightYGeo(size: CGSize) -> CGFloat {
        return axisToGeo(size: size, coord: self.lowerRight.y, bounds: self, horizontal: false)
    }
    func topLeftXGeo(size: CGSize) -> CGFloat {
        return axisToGeo(size: size, coord: self.topLeft.x, bounds: self, horizontal: true)
    }
    func topLeftYGeo(size: CGSize) -> CGFloat {
        return axisToGeo(size: size, coord: self.lowerRight.x, bounds: self, horizontal: false)
    }
}

extension Bounds: VectorArithmetic {
    static var zero: Bounds {
        return Bounds(topLeft: CGPoint(x: 0, y: 0), lowerRight: CGPoint(x: 0, y: 0))
    }
    
    var magnitudeSquared: Double {
        return pow((Double(abs(self.topLeft.y - self.lowerRight.y) + abs(self.lowerRight.x - self.topLeft.x))), 2)
    }
    
    static func -= (lhs: inout Bounds, rhs: Bounds) {
        lhs = lhs - rhs
    }
    
    static func - (lhs: Bounds, rhs: Bounds) -> Bounds {
        // essentially make a bounds w/o the second one?
        var topLeftX = lhs.topLeft.x
        var topLeftY = lhs.topLeft.y
        var lowerRightX = lhs.lowerRight.x
        var lowerRightY = lhs.lowerRight.y
        
        if rhs.topLeft.x > lhs.lowerRight.x || rhs.lowerRight.y > lhs.topLeft.y || rhs.topLeft.y < lhs.lowerRight.y || rhs.lowerRight.x < lhs.topLeft.x {
            return lhs
        }
        if rhs.topLeft.x < lhs.lowerRight.x {
            if rhs.lowerRight.x < lhs.lowerRight.x {
                topLeftX = rhs.lowerRight.x
            } else if rhs.lowerRight.x > lhs.lowerRight.x {
                lowerRightX = rhs.topLeft.x
            }
        }
        if rhs.topLeft.y > lhs.lowerRight.y {
            if rhs.lowerRight.y > lhs.lowerRight.y {
                topLeftY = rhs.lowerRight.y
            } else if rhs.lowerRight.y < lhs.lowerRight.y {
                lowerRightY = rhs.topLeft.y
            }
        }
        if rhs.lowerRight.x > lhs.topLeft.x {
            if rhs.topLeft.x > lhs.topLeft.x {
                lowerRightX = rhs.topLeft.x
            } else if rhs.topLeft.x < lhs.topLeft.x {
                topLeftX = rhs.lowerRight.x
            }
        }
        if rhs.lowerRight.y < lhs.topLeft.y {
            if rhs.topLeft.y < lhs.topLeft.y {
                lowerRightY = rhs.topLeft.y
            } else if rhs.topLeft.y > lhs.topLeft.y {
                topLeftY = rhs.lowerRight.y
            }
        }
        let result = Bounds(topLeft: CGPoint(x: topLeftX, y: topLeftY), lowerRight: CGPoint(x: lowerRightX, y: lowerRightY))
        return result
    }
    
    static func += (lhs: inout Bounds, rhs: Bounds) {
        lhs = lhs + rhs
    }
    
    static func + (lhs: Bounds, rhs: Bounds) -> Bounds {
        // essentially make a bounds containing both areas
        let result =  Bounds(topLeft: CGPoint(x: min(lhs.topLeft.x, rhs.topLeft.x), y: max(lhs.topLeft.y, rhs.topLeft.y)), lowerRight: CGPoint(x: max(lhs.lowerRight.x, rhs.lowerRight.x), y: min(lhs.lowerRight.y, rhs.lowerRight.y)))
        return result
        
    }
    
    func zoom(by rhs: Double) -> Bounds {
        let xChange = (abs(abs(self.topLeft.x - self.lowerRight.x) - (abs(self.topLeft.x - self.lowerRight.x) * rhs))) / 2
        let yChange = (abs(abs(self.topLeft.y - self.lowerRight.y) - (abs(self.topLeft.y - self.lowerRight.y) * rhs))) / 2
        if rhs < 1 {
            let topLeft = CGPoint(x: (self.topLeft.x + xChange), y: (self.topLeft.y - yChange))
            let lowerRight = CGPoint(x: (self.lowerRight.x - xChange), y: (self.lowerRight.y + yChange))
            return Bounds(topLeft: topLeft, lowerRight: lowerRight)
        } else if rhs > 1 {
            let topLeft = CGPoint(x: (self.topLeft.x - xChange), y: (self.topLeft.y + yChange))
            let lowerRight = CGPoint(x: (self.lowerRight.x + xChange), y: (self.lowerRight.y - yChange))
            return Bounds(topLeft: topLeft, lowerRight: lowerRight)
        }
        return self
    }
    
    mutating func scale(by rhs: Double) {
        self = zoom(by: rhs)
    }
}
