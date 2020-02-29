//
//  ColorSliderView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/21/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    var range: ClosedRange<Double> = 0...1
    var color: Color = .blue
    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: [.black,color,.white]), startPoint: .leading, endPoint: .trailing)
        
        return GeometryReader { geometry in
            ZStack(alignment: .leading){
                gradient
                .cornerRadius(20)
                .frame(height: 10)
                
                SliderCircleView( value: self.$sliderValue,
                                  range: self.range,
                                  sliderWidth: geometry.size.width)
            }
        }
            
        
    }
}

struct ColorSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSliderView(sliderValue: .constant(50),
                        range: 0...50,
                        color: .blue
        )
    }
}

struct SliderCircleView: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let diameter: CGFloat = 30
    @State private var offset: CGSize = .zero
    let sliderWidth: CGFloat
    
    var sliderValue: Double {
        let percent = Double(offset.width / (sliderWidth - diameter))
        let value = (range.upperBound - range.lowerBound) * percent + range.lowerBound
        return value
    }
        
    var body: some View {
        let drag = DragGesture()
            .onChanged {
                self.offset.width =
                self.clampWidth(translation: $0.translation.width)
                self.value = self.sliderValue
        }
        
        return Circle()
            .foregroundColor(.white)
            .shadow(color: .gray, radius: 1)
            .frame(width: diameter, height: diameter)
        .gesture(drag)
        .offset(offset)
    }
    
    func clampWidth(translation: CGFloat) -> CGFloat {
        return min(sliderWidth - diameter,
                   max(0, offset.width + translation))
    }
}
