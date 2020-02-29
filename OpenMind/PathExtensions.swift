/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import CoreGraphics
import SwiftUI

//  Hermite Spline Interpolation
//
//  Created by Simon Gladman on 04/11/2015.
//  Copyright © 2015 Simon Gladman. All rights reserved.
//  Used with permission - thank you Simon!
//  flexmonkey.blogspot.co.uk

extension Path {
  mutating func interpolatePointsWithHermite(interpolationPoints : [CGPoint], alpha : CGFloat = 1.0/3.0) {
    
    guard !interpolationPoints.isEmpty else { return }
    self.move(to: interpolationPoints[0])
    
    let n = interpolationPoints.count - 1
    
    for index in 0..<n {
      var currentPoint = interpolationPoints[index]
      var nextIndex = (index + 1) % interpolationPoints.count
      var prevIndex = index == 0 ? interpolationPoints.count - 1 : index - 1
      var previousPoint = interpolationPoints[prevIndex]
      var nextPoint = interpolationPoints[nextIndex]
      let endPoint = nextPoint
      var mx: CGFloat
      var my: CGFloat
      
      if index > 0 {
        mx = (nextPoint.x - previousPoint.x) / 2.0
        my = (nextPoint.y - previousPoint.y) / 2.0
      }
      else {
        mx = (nextPoint.x - currentPoint.x) / 2.0
        my = (nextPoint.y - currentPoint.y) / 2.0
      }
      
      let controlPoint1 = CGPoint(x: currentPoint.x + mx * alpha, y: currentPoint.y + my * alpha)
      currentPoint = interpolationPoints[nextIndex]
      nextIndex = (nextIndex + 1) % interpolationPoints.count
      prevIndex = index
      previousPoint = interpolationPoints[prevIndex]
      nextPoint = interpolationPoints[nextIndex]
      
      if index < n - 1 {
        mx = (nextPoint.x - previousPoint.x) / 2.0
        my = (nextPoint.y - previousPoint.y) / 2.0
      }
      else {
        mx = (currentPoint.x - previousPoint.x) / 2.0
        my = (currentPoint.y - previousPoint.y) / 2.0
      }
      
      let controlPoint2 = CGPoint(x: currentPoint.x - mx * alpha, y: currentPoint.y - my * alpha)
      self.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
    }
  }
}

extension UIBezierPath {
  func interpolatePointsWithHermite(interpolationPoints : [CGPoint], alpha : CGFloat = 1.0/3.0) {
    guard !interpolationPoints.isEmpty else { return }
    self.move(to: interpolationPoints[0])
    
    let n = interpolationPoints.count - 1
    
    for index in 0..<n {
      var currentPoint = interpolationPoints[index]
      var nextIndex = (index + 1) % interpolationPoints.count
      var prevIndex = index == 0 ? interpolationPoints.count - 1 : index - 1
      var previousPoint = interpolationPoints[prevIndex]
      var nextPoint = interpolationPoints[nextIndex]
      let endPoint = nextPoint
      var mx: CGFloat
      var my: CGFloat
      
      if index > 0 {
        mx = (nextPoint.x - previousPoint.x) / 2.0
        my = (nextPoint.y - previousPoint.y) / 2.0
      }
      else {
        mx = (nextPoint.x - currentPoint.x) / 2.0
        my = (nextPoint.y - currentPoint.y) / 2.0
      }
      
      let controlPoint1 = CGPoint(x: currentPoint.x + mx * alpha, y: currentPoint.y + my * alpha)
      currentPoint = interpolationPoints[nextIndex]
      nextIndex = (nextIndex + 1) % interpolationPoints.count
      prevIndex = index
      previousPoint = interpolationPoints[prevIndex]
      nextPoint = interpolationPoints[nextIndex]
      
      if index < n - 1 {
        mx = (nextPoint.x - previousPoint.x) / 2.0
        my = (nextPoint.y - previousPoint.y) / 2.0
      }
      else {
        mx = (currentPoint.x - previousPoint.x) / 2.0
        my = (currentPoint.y - previousPoint.y) / 2.0
      }
      
      let controlPoint2 = CGPoint(x: currentPoint.x - mx * alpha, y: currentPoint.y - my * alpha)
      self.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
  }
}
