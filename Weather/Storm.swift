//
//  Storm.swift
//  Weather
//
//  Created by Mehmet Alp Sönmez on 03/01/2025.
//

import SwiftUI

class Storm {
    enum Contents: CaseIterable {
        case none, rain, snow
    }
    
    var drops = [StormDrop]()
    var lastUpdate = Date.now
    var image: Image
    
    init(type: Contents, direction: Angle, strength: Int) {
        switch type {
        case .snow:
            image = Image("snow")
        default:
            image = Image("rain")
        }

        for _ in 0..<strength {
            drops.append(StormDrop(type: type, direction: direction + .degrees(90)))
        }
    }
    
    func update(date: Date, size: CGSize) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
        
        let divisor = size.height / size.width
        
        for drop in drops {
            let radians = drop.direction.radians
            
            drop.x += cos(radians) * drop.speed * delta * divisor
            drop.y += sin(radians) * drop.speed * delta
            
            if drop.x < -0.2 {
                drop.x += 1.4
            }

            if drop.y > 1.2 {
                drop.x = Double.random(in: -0.2...1.2)
                drop.y -= 1.4
            }

            drop.rotation += drop.rotationSpeed * delta

        }
        
        lastUpdate = date
    }
}
