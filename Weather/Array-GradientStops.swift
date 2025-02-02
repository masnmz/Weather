//
//  Array-GradientStops.swift
//  Weather
//
//  Created by Mehmet Alp Sönmez on 01/01/2025.
//

import SwiftUI

extension Array where Element == Gradient.Stop {
    func interpolated(amount: Double) -> Color {
        guard let initialStop = self.first else {
            fatalError("Attempt to read colour from empty stop array")
        }
        
        var firstStop = initialStop
        var secondStop = initialStop
        
        for stop in self {
            if stop.location < amount {
                firstStop = stop
            } else {
                secondStop = stop
                break
            }
        }
        
        let totalDifference = secondStop.location -  firstStop.location
        
        if totalDifference > 0 {
            let relativeDifference = (amount - firstStop.location) / totalDifference
            return firstStop.color.interpolated(to: secondStop.color, amount: relativeDifference)
        } else {
            return firstStop.color.interpolated(to: secondStop.color, amount: 0)
        }
    }
}
