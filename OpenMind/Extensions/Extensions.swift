//
//  Extensions.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/20/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import Foundation
import SwiftUI

extension View{
    func endTextEditing(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


func +(left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width+right.width, height: left.height+right.height)
}
