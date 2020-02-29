//
//  BackgroundView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/19/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    
    @EnvironmentObject var cellData: CellData
    let size: CGSize
    
    var body: some View {
        let doubleTapDrag = DragGesture(minimumDistance: 0)
        
        let doubleTap = TapGesture(count: 2)
            .sequenced(before: doubleTapDrag)
            .onEnded { value in
                switch value {
                case .second((), let drag):
                    if let drag = drag {
                        print("add a new cell at: ", drag.location)
                        self.newCell(location: drag.location)
                    }
                default:
                    break
                }
        }
        
        return ZStack{
            GridView()
                .edgesIgnoringSafeArea(.all)
            ForEach(self.cellData.cells) { cell in
                CellView(cell: cell)
            }
        }
        .gesture(doubleTap)
        .onTapGesture {
            self.cellData.selectedCell = nil
            self.endTextEditing()
        }
    }
    
    func newCell(location: CGPoint){
        let offsetX = location.x - size.width / 2
        let offsetY = location.y - size.height / 2
        let offset = CGSize(width: offsetX,
                            height: offsetY)
        let cell = cellData.addCell(offset: offset)
        cellData.selectedCell = cell
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(size: CGSize(width: 400, height: 800))
        .environmentObject(CellData())
    }
}
