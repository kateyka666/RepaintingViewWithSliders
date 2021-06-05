//
//  Color.swift
//  RepaintingViewWithSliders
//
//  Created by Екатерина Боровкова on 03.06.2021.
//

import Foundation
struct Color {
    var redColor :Float
    var greenColor :Float
    var blueColor : Float
    var alpha : Float = 1.0
    
    static func makeColor () -> Color {
        return Color(redColor: 1, greenColor: 1, blueColor: 1)
    }
}
