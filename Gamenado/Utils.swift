//
//  Utils.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 08/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import Foundation
import CoreGraphics

let π = CGFloat(Double.pi)

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func += ( left: inout CGPoint, right: CGPoint) {
    left = left + right
}
func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
func -= ( left: inout CGPoint, right: CGPoint) { left = left - right
}
func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}
func *= ( left: inout CGPoint, right: CGPoint) { left = left * right
}
func * (point: CGPoint, scalar: CGFloat) -> CGPoint { return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
func *= ( point: inout CGPoint, scalar: CGFloat) { point = point * scalar
}
func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}
func /= ( left: inout CGPoint, right: CGPoint) {
    left = left / right }
func / (point: CGPoint, scalar: CGFloat) -> CGPoint { return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
func /= ( point: inout CGPoint, scalar: CGFloat) { point = point / scalar
}

#if !(arch(x86_64) || arch(arm64))
    func atan2(y: CGFloat, x: CGFloat) -> CGFloat {
        return CGFloat(atan2f(Float(y), Float(x))) }
    func sqrt(a: CGFloat) -> CGFloat { return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat { return sqrt(x*x + y*y)
    }
    func normalized() -> CGPoint { return self / length()
    }
    var angle: CGFloat { return atan2(y, x)
    }
}

func shortestAngleBetween(angle1: CGFloat, angle2: CGFloat) -> CGFloat {
    let twoπ = π * 2.0
    var angle = (angle2 - angle1).truncatingRemainder(dividingBy: twoπ)
    
    if (angle >= π) {
        angle = angle - twoπ }
    
    if (angle <= -π) { angle = angle + twoπ
    }
    
    return angle
}

extension CGFloat {
    func sign() -> CGFloat {
        return (self >= 0.0) ? 1.0 : -1.0 }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:(Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
