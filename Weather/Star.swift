//
//  Star.swift
//  Weather
//
//  Created by Mehmet Alp Sönmez on 02/01/2025.
//

import Foundation

class Star {
    var x: Double
    var y: Double
    var size: Double
    var flickerInterval: Double
    
    init(x: Double, y: Double, size: Double) {
        self.x = x
        self.y = y
        self.size = size
        
        if size > 2 && y < 250 {
            flickerInterval = Double.random(in: 3...20)
        } else {
            flickerInterval = 0 
        }
    }
}
