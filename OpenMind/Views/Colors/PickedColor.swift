//
//  Colors.swift
//  OpenMind
//
//  Created by Ruben Maldonado Tena on 2/24/20.
//  Copyright © 2020 Ruben Maldonado. All rights reserved.
//

import Foundation
import SwiftUI

enum PickedColor: CaseIterable {
    case black
    case blue
    case green
    case orange
    case red
    case yellow
    
    var color: Color {
        return Color(uiColor)
    }
    
    var uiColor: UIColor{
        switch self {
        case .black:
            return UIColor(named: "Black")!
        case .blue:
            return UIColor(named: "Blue")!
        case .green:
            return UIColor(named: "Green")!
        case .orange:
            return UIColor(named: "Orange")!
        case .red:
            return UIColor(named: "Red")!
        case .yellow:
            return UIColor(named: "Yellow")!
        }
    }
    
}

