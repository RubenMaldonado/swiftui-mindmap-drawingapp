//
//  CanvasView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/28/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import Foundation
import UIKit

class CanvasView: UIControl {
    private let defaultLineWidth: CGFloat = 6
    private let minLineWidth: CGFloat = 5
    private let forceSensitivity: CGFloat = 4
    private let tiltThreshold: CGFloat = .pi / 6
    
    var drawingImage: UIImage?
    var drawColor: UIColor = .blue {
        didSet{
            shadingColor = drawColor
        }
    }
    
    var shadingColor: UIColor = .blue {
        didSet{
            let image = UIImage(named: "pencilTexture")!
            let tintedImage = UIGraphicsImageRenderer(size: image.size).image { _ in
                drawColor.set()
                image.draw(at: .zero)
            }
            shadingColor = UIColor(patternImage: tintedImage)
        }
    }
    
    init(color: UIColor, drawingImage: UIImage?){
        self.drawColor = color
        self.drawingImage = drawingImage
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendActions(for: .valueChanged)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        drawingImage = UIGraphicsImageRenderer(size: bounds.size).image { context in
            UIColor.white.setFill()
            context.fill(bounds)
            drawingImage?.draw(in: bounds)
            
            var touches = [UITouch]()
            if let coalescedTouches = event?.coalescedTouches(for: touch){
                touches = coalescedTouches
            }else{
                touches.append(touch)
            }
            
            print("Touch count:", touches.count)
            for touch in touches{
                drawStroke(context: context.cgContext, touch: touch)
            }
            
            setNeedsDisplay()
         }
    }
    
    private func drawStroke(context: CGContext, touch: UITouch){
        let previousLocation = touch.previousLocation(in: self)
        let location = touch.location(in: self)
        
        var lineWidth: CGFloat
        
        if touch.altitudeAngle < tiltThreshold {
            lineWidth = lineWidthForShading(touch: touch)
            shadingColor.setStroke()
            
            let minForce: CGFloat = 0
            let maxForce: CGFloat = 4
            let normalizedAlpha = (touch.force - minForce) / (maxForce - minForce)
            context.setAlpha(normalizedAlpha)
        } else {
            lineWidth = defaultLineWidth
            if touch.force > 0 {
                lineWidth = touch.force * forceSensitivity
            }
            drawColor.setStroke()
        }
        
        context.setLineWidth(lineWidth)
        //drawColor.setStroke()
        context.setLineCap(.round)
        
        context.move(to: previousLocation)
        context.addLine(to: location)
        context.strokePath()
    }
    
    private func lineWidthForShading(touch: UITouch) -> CGFloat {
        let maxLineWidth: CGFloat = 60
        let minAltitudeAngle: CGFloat = 0.25
        let maxAltitudeAngle = tiltThreshold
        let altitudeAngle = max(minAltitudeAngle, touch.altitudeAngle)
        
        let normalizedAltitude = (altitudeAngle - minAltitudeAngle) / (maxAltitudeAngle - minAltitudeAngle)
        
        return max(maxLineWidth * (1 - normalizedAltitude), minLineWidth)
    }
    
    override func draw(_ rect: CGRect) {
        drawingImage?.draw(in: rect)
    }
    
}
