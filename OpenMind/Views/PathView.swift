//
//  PathView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/18/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct PathView: View {
    @State private var showShapes = false
    
    var body: some View {
        ZStack {
            GeometryReader{ geometryProxy in
                ZStack{
                    Color.yellow
                    Button("Show Shapes") {
                        self.showShapes.toggle()
                    }
                    .frame(height: geometryProxy.size.height / 2)
                    .background(Color.gray)
                }
            }
            
        }
    }
}



struct PathView_Previews: PreviewProvider {
    static var previews: some View {
        PathView()
    }
}
