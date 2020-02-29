//
//  ShapeGridView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/19/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct ShapeGridView: View {
    @Binding var selectedIndex: Int
    
    
    var body: some View {
        UITableView.appearance().separatorColor = .clear
        
        
        let cellSize = CGSize(width: 100, height: 100)
        return GeometryReader{ geometry in
            List{
                ShapesGrid(selectedIndex: self.$selectedIndex, allShapes: ShapeType.allCases, cellSize: cellSize, viewSize: geometry.size)
                    .padding(.leading, -15)
            }.listRowInsets(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: 0))
        }
    }
}

struct ShapesGrid: View {
    
    @Binding var selectedIndex: Int
    @Environment(\.presentationMode) var presentationMode
    
    let allShapes: [ShapeType]
    let cellSize: CGSize
    let viewSize: CGSize
    let padding: CGFloat = 10
    
    var columns: Int{
        var columns = viewSize.width  / cellSize.width
        while (columns * cellSize.width + padding * columns) > viewSize.width {
            columns -= 1
        }
        return Int(columns)
    }
    
    var finalArray: [[ShapeType]] {
        var array: [[ShapeType]] = []
        var rowArray: [ShapeType] = []
        
        for i in 0..<allShapes.count {
            if i % columns == 0 {
                if i != 0 {
                    array.append(rowArray)
                }
                rowArray = []
            }
            rowArray.append((allShapes[i]))
        }
        
        while rowArray.count < columns {
            rowArray.append(ShapeType.empty)
        }
        array.append(rowArray)
        
        return array
    }
    
    var body: some View {
        ForEach(0..<finalArray.count){ rowIndex in
            HStack(spacing: 0){
                ForEach(0..<self.finalArray[rowIndex].count){ columnIndex in
                    self.finalArray[rowIndex][columnIndex].shape
                    .stroke()
                        .frame(width: self.cellSize.width,
                               height: self.cellSize.height)
                        .padding(self.padding)
                        .onTapGesture {
                            self.selectedIndex = rowIndex * self.columns + columnIndex
                            self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }
            .frame(width: self.viewSize.width)
        }
    }
}

struct ShapeGridView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeGridView(selectedIndex: .constant(0))
    }
}
