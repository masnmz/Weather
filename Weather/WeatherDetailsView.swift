//
//  WeatherDetailsView.swift
//  Weather
//
//  Created by Mehmet Alp Sönmez on 06/01/2025.
//

import SwiftUI

struct WeatherDetailsView: View {
    let tintColour: Color
    
    
    let residueType: Storm.Contents
    let residueStrength: Double
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ResidueView(type: residueType, strength: residueStrength)
                    .frame(height: 62)
                    .offset(y:30)
                    .zIndex(1)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(tintColour.opacity(0.25))
                    .frame(height: 800)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 20)
            }
            .padding(.top, 200)
        }
    }
}

#Preview {
    WeatherDetailsView(tintColour: .blue, residueType: .rain, residueStrength: 200)
}
