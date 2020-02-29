//
//  CircleImageWithGradientView.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/20/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import SwiftUI

struct CircleImageWithGradientView: View {
    var gradient: Gradient {
       //let colors: [Color] = [.red, .green, .blue]
       //return Gradient(colors: colors)
       
       let stops: [Gradient.Stop] = [
           .init(color: .red, location: 0.1),
           .init(color: .blue, location: 0.8)
       ]
       
       return Gradient(stops: stops)
   }
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            Image("2017DodgeChallenger")
                .resizable()
                .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
                .overlay(Circle()
                    .stroke(lineWidth: 8)
                    .foregroundColor(.white)
            )
                .frame(width: 250)
        }
    }
}

struct CircleImageWithGradientView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleImageWithGradientView().colorScheme(.light)
            CircleImageWithGradientView().colorScheme(.dark)
        }
    }
}
