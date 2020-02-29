//
//  DrawingPad.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/28/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct DrawingPad: View {
    @EnvironmentObject var modalViews: ModalViews
    @EnvironmentObject var cellData: CellData
    
    @State var pickedColor: PickedColor
    @State var drawingImage: UIImage?
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button("Cancel") {
                        self.modalViews.showDrawingPad = false
                    }
                    .padding(.leading)
                    Spacer()
                    Button("Done") {
                        self.modalViews.showDrawingPad = false
                        if let drawingImage = self.drawingImage,
                            let cell = self.cellData.selectedCell {
                            let index = self.cellData.indexOf(cell: cell)
                            self.cellData.cells[index].update(drawingImage: drawingImage)
                        }
                    }
                    .padding(.trailing)
                }
                DrawingPadRepresntation(drawingImage: $drawingImage, pickedColor: pickedColor)
                Divider()
                ColorPicker(pickedColor: $pickedColor)
            }
        }
        
        
    }
}

struct DrawingPad_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPad(pickedColor: .red)
    }
}
