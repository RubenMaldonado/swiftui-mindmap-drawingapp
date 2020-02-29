//
//  ContentView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/18/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cellData: CellData
    @EnvironmentObject var modalViews: ModalViews
        
    @State private var showShapes = false
    @State private var shapeIndex = 0
    
    var body: some View {
        
        let shapeIndex = Binding<Int>(
            get: {
                self.shapeIndex
            },
            set: {
                self.shapeIndex = $0
                if let cell = self.cellData.selectedCell {
                    let index = self.cellData.indexOf(cell: cell)
                    let shapeType = ShapeType.allCases[self.shapeIndex]
                    self.cellData.cells[index].update(shapeType: shapeType)
                }
            }
        )
        
        
        return
            ZStack {
                GeometryReader{ geometry in
                    BackgroundView(size: geometry.size)
                        .sheet(isPresented: self.$modalViews.showShapes) {
                            ShapeGridView(selectedIndex: shapeIndex)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .sheet(isPresented: self.$modalViews.showShapes) {
                    ShapeGridView(selectedIndex: shapeIndex)
                }
                
                self.modalViews.showDrawingPad ? DrawingPad(pickedColor: .red, drawingImage: self.cellData.selectedCell?.drawingImage)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5))
                    .zIndex(10)
                : nil
        }
            /*
            HStack {
                ColorSliderView(sliderValue: self.$sliderValue, range: 0...255, color: .yellow)
                Text("\(sliderValue)")
            }.padding()
                .frame(height: 80)
            */
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().colorScheme(.light)
                .environmentObject(CellData())
            .environmentObject(ModalViews())
            ContentView().colorScheme(.dark)
                .environmentObject(CellData())
            .environmentObject(ModalViews())
        }
    }
}
