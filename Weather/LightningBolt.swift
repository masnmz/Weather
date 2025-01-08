//
//  LightningBolt.swift
//  Weather
//
//  Created by Mehmet Alp Sönmez on 08/01/2025.
//

import SwiftUI

class LightningBolt {
    var points = [CGPoint]()
    var width: Double
    var angle: Double
    
    init(start: CGPoint, width: Double, angle: Double) {
        points.append(start)
        self.width = width
        self.angle = angle
    }
}
