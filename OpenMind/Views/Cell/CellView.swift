//
//  CellView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/19/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var cellData: CellData
    @EnvironmentObject var modalViews: ModalViews
    
    @State private var text: String = ""
    @State private var offset: CGSize = .zero
    @State private var currentOffset: CGSize = .zero
    let cell:Cell
    
    static var crayonImage: Image {
        let config = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .medium,
            scale: .medium)
        return Image(uiImage: UIImage(named: "crayon")!.withConfiguration(config))
    }
    
    var isSelected: Bool {
        cell == cellData.selectedCell
    }
    
    func setupOptions() -> [FlyoutMenuOption] {
        let flyoutMenuOptions: [FlyoutMenuOption] = [
            FlyoutMenuOption(image: Image(systemName: "trash"), color: .blue, action: {
                self.cellData.delete(cell: self.cell)
            }),
            FlyoutMenuOption(image: Image(systemName: "square.on.circle"), color: .green, action: {
                self.modalViews.showShapes = true
                print(self.modalViews.showShapes)
            }),
            FlyoutMenuOption(image: Image(systemName: "link"), color: .purple),
            FlyoutMenuOption(image: Self.crayonImage, color: .orange, action: {
                self.modalViews.showDrawingPad = true
            })
        ]
        
        return flyoutMenuOptions
    }
    
    
    
    
    var body: some View {
        let flyoutMenuOptions = setupOptions()
        
        let drag = DragGesture()
            .onChanged { drag in
                self.offset = self.currentOffset + drag.translation
        }.onEnded { (drag) in
            self.offset = self.currentOffset + drag.translation
            self.currentOffset = self.offset
        }
        
        return ZStack{
            cell.shapeType.shape.foregroundColor(Color.white)
            
            TextField("Enter cell text", text: $text)
                .padding()
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            CellThumbnail(cell: cell)
                .clipShape(cell.shapeType.shape)
            
            cell.shapeType.shape.stroke(isSelected ? Color.orange : cell.color, lineWidth: 3)
            
            if isSelected {
                FlyoutMenu(flyoutOptions: flyoutMenuOptions)
                    .offset(x: cell.size.width / 2,
                            y: -cell.size.height / 2)
            }
            
            
            
        }
        .frame(width: cell.size.width, height: cell.size.height)
        .offset(cell.offset + offset)
        .onAppear(){
            self.text = self.cell.text
        }
        .onTapGesture{
            self.cellData.selectedCell = self.cell
        }
    .simultaneousGesture(drag)
        
    }
}


struct CellThumbnail: View {
    let cell: Cell
    var body: some View {
        cell.thumbnail != nil ?
            ZStack {
                Color.white
            cell.thumbnail!
                .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: cell.size.width, height: cell.size.height)
        }
        : nil
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(cell: Cell())
            .previewLayout(.sizeThatFits)
        .padding()
        .environmentObject(CellData())
    }
}
