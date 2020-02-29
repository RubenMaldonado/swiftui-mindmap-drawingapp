//
//  Shapes.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/18/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct AnyShape: Shape {
    private let path: (CGRect) -> Path
    
    init<T: Shape> (_ shape: T) {
        path = { rect in
            return shape.path(in: rect)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return path(rect)
    }
}


enum ShapeType: CaseIterable{
    case rectangle
    case ellipse
    case diamond
    case chevron
    case heart
    case roundedRect
    case empty
    
    var shape: some Shape {
        switch self {
        case .rectangle:
            return Rectangle().anyShape()
        case .ellipse:
            return Ellipse().anyShape()
        case .diamond:
            return Diamond().anyShape()
        case .chevron:
            return Chevron().anyShape()
        case .heart:
            return Heart().anyShape()
        case .roundedRect:
            return RoundedRectangle(cornerRadius: 30).anyShape()
        case .empty:
            return Path().anyShape()
        
        }
    }
}
    
extension Shape {
    func anyShape() -> AnyShape {
        return AnyShape(self)
    }
}
    

struct Shapes: View {
    var body: some View {
        Chevron()
            .stroke(style: StrokeStyle( lineWidth: 10, lineCap: .round))
            .foregroundColor(Color.red)
        .padding()
        .frame(height: 300)
    }
}

struct Chevron: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
         let width = rect.width
         let height = rect.height
            
        path.addLines([
            CGPoint(x: 0, y:0),
            CGPoint(x: width * 0.75, y:0),
            CGPoint(x: width, y: height * 0.5),
            CGPoint(x: width * 0.75, y: height),
            CGPoint(x: width * 0, y: height),
            CGPoint(x: width * 0.25, y: height * 0.5)
        ])
        path.closeSubpath()
            
        return path
    }
    
    
    
}

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.width * 0.25,
                                    y: rect.height * 0.25),
                    radius: rect.width * 0.25,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 180),
                    clockwise: true)
        
        let control1 = CGPoint(x: 0,
                               y: rect.height * 0.8)
        
        let control2 = CGPoint(x: rect.width * 0.25,
                               y: rect.height * 0.95)
        
        path.addCurve(to: CGPoint(x: rect.width * 0.5,
                                  y: rect.height),
                      control1: control1,
                      control2: control2)
        
        var transform = CGAffineTransform(translationX: rect.width,
                                          y: 0)
        transform = transform.scaledBy(x: -1, y: 1)
        path.addPath(path, transform: transform)
        
        
        
        return path
    }
    
    
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
         Path { path in
            let width = rect.width
            let height = rect.height
               
               path.addLines([
                   CGPoint(x: width / 2, y:0),
                   CGPoint(x: width, y: height / 2),
                   CGPoint(x: width / 2, y: height),
                   CGPoint(x: 0, y: height / 2)
               ])
               path.closeSubpath()
           }
    }
}


struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
    }
}
