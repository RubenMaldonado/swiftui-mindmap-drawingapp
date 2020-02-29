//
//  DrawingPadSwiftUI.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/27/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct DrawingPath: Identifiable{
    var id: UUID = UUID()
    var path = Path()
    var points: [CGPoint] = []
    var color: Color = .black
    
    mutating func addLine(to point: CGPoint, color: Color){
        if path.isEmpty {
            path.move(to: point)
            self.color = color
        }else {
            path.addLine(to: point)
        }
        points.append(point)
    }
    
    mutating func smoothLine(){
        var newPath = Path()
        
        newPath.interpolatePointsWithHermite(interpolationPoints: points)
        
        path = newPath
    }
}

struct DrawingPadSwiftUI: View {
    @State private var paths: [DrawingPath] = []
    @State private var drawingPath = DrawingPath()
    //@State private var strokeColor: Color = .black
    @State private var pickedColor: PickedColor = .black
    
    var body: some View {
        let drag = DragGesture(minimumDistance: 0)
            .onChanged({ stroke in
                self.drawingPath.addLine(to: stroke.location, color: self.pickedColor.color)
                print(stroke.location)
            })
            .onEnded { stroke in
                self.drawingPath.smoothLine()
                
                if !self.drawingPath.path.isEmpty {
                    self.paths.append(self.drawingPath)
                }
                self.drawingPath = DrawingPath()
        }
        
        return VStack {
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(.all)
                .gesture(drag)
                
                ForEach(paths) { drawingPath in
                    drawingPath.path
                        .stroke(drawingPath.color)
                    
                }
                drawingPath.path.stroke(drawingPath.color)
            }
            Divider()
            ColorPicker(pickedColor: $pickedColor)
                .frame(height: 80)
        }
        
    }
}

struct DrawingPadSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPadSwiftUI()
    }
}
