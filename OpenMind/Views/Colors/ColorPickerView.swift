//
//  ColorPickerView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/24/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct ColorPickerView: View {
    @State var pickedColor: PickedColor = .red
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(pickedColor.color)
            ColorPicker(pickedColor: self.$pickedColor)
        }
    }
}

struct ColorPicker: View {
    @Binding var pickedColor: PickedColor
    
    let diameter: CGFloat = 40
    
    var body: some View {
        HStack {
            ForEach(PickedColor.allCases, id: \.self) { picked in
                ZStack {
                    Circle()
                        .foregroundColor(picked.color)
                        .frame(width: self.diameter,
                               height: self.diameter)
                        .onTapGesture {
                            self.pickedColor = picked
                    }
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: self.pickedColor == picked ? self.diameter * 0.25 : 0)
                }
            }
        }
        .frame(height: diameter * 3)
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}
