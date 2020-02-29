//
//  Model.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/19/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


let minCellSize = CGSize(width: 200, height: 100)

struct Cell: Identifiable, Equatable {
    var id = UUID()
    var color = Color.black
    var size = minCellSize
    var offset = CGSize.zero
    var shapeType = ShapeType.roundedRect
    var text = "Default cell text"
    var drawingImage: UIImage?
    var thumbnail: Image? {
        guard let drawingImage = self.drawingImage else {return nil}
        let thumbnailSize = CGSize(width: drawingImage.size.width / 6, height: drawingImage.size.height / 6)
        
        let thumbnail = UIGraphicsImageRenderer(size: thumbnailSize).image { context in
            drawingImage.draw(in: CGRect(origin: .zero, size: thumbnailSize))
        }
        
        return Image(uiImage: thumbnail)
    }
    
    mutating func update(shapeType: ShapeType){
        self.shapeType = shapeType
    }
    
    mutating func update(drawingImage: UIImage){
        self.drawingImage = drawingImage
    }
    
}

class CellData: ObservableObject {
    @Published var selectedCell: Cell?
    @Published var cells: [Cell] = [
        Cell(color: .red,
             text: "Dwawing in SwiftUI"),
        Cell(color: .green,
             offset: CGSize(width: 100, height: 300),
             text: "Shapes"),
        
    ]
    
    func indexOf(cell: Cell) -> Int {
        guard let index = cells.firstIndex(where: {
            $0.id == cell.id
        }) else {
            fatalError("Cell \(cell) does not exist")
        }
        return index
    }
    
    
    func addCell(offset: CGSize) -> Cell {
        let cell = Cell(offset: offset)
        cells.append(cell)
        return cell
    }
    
    func delete(cell: Cell?){
        guard let cell = cell else {
            return
        }
        
        if selectedCell == cell {
            selectedCell = nil
        }
        
        cells.removeAll {
            $0.id == cell.id
        }
    }
    
}
