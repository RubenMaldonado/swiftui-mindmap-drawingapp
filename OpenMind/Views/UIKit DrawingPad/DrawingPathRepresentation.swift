//
//  DrawingPathRepresentation.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/28/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import Foundation
import SwiftUI

struct DrawingPadRepresntation: UIViewRepresentable {
    
    @Binding var drawingImage: UIImage?
    let pickedColor: PickedColor
    
    class Coordinator: NSObject {
        @Binding var drawingImage: UIImage?
        
        init(drawingImage: Binding<UIImage?>) {
            _drawingImage = drawingImage
        }
        
        @objc func drawingImageChanged(_ sender: CanvasView){
            self.drawingImage = sender.drawingImage
        }
    }
    
    func makeCoordinator() -> DrawingPadRepresntation.Coordinator {
        Coordinator(drawingImage: $drawingImage)
    }
    
    func makeUIView(context: Context) -> CanvasView {
        let view = CanvasView(color: pickedColor.uiColor, drawingImage: drawingImage)
        
        view.addTarget(context.coordinator, action: #selector(Coordinator.drawingImageChanged(_:)), for: .valueChanged)
        
        return view
    }
    
    func updateUIView(_ uiView: CanvasView, context: Context) {
        uiView.drawColor = pickedColor.uiColor
    }
}
