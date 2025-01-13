//
//  ContentView.swift
//  Weather
//
//  Created by Mehmet Alp Sönmez on 01/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var cloudThickness = Cloud.Thickness.regular
    @State private var time = 0.0
    
    @State private var stormType = Storm.Contents.none
    @State private var rainIntensity = 500.0
    @State private var rainAngle = 0.0
    
    @State private var lightningMaxBolts = 4.0
    @State private var lightningForkProbability = 20.0
    
    @State private var showingControl = true
    
    
    let backgroundTopStops: [Gradient.Stop] = [
        .init(color: .midnightStart, location: 0),
        .init(color: .midnightStart, location: 0.25),
        .init(color: .sunriseStart, location: 0.33),
        .init(color: .sunnyDayStart, location: 0.38),
        .init(color: .sunnyDayStart, location: 0.7),
        .init(color: .sunsetStart, location: 0.78),
        .init(color: .midnightStart, location: 0.82),
        .init(color: .midnightStart, location: 1),
    ]
    
    let backgroundBottomStops: [Gradient.Stop] = [
        .init(color: .midnightEnd, location: 0),
        .init(color: .midnightEnd, location: 0.25),
        .init(color: .sunriseEnd, location: 0.33),
        .init(color: .sunnyDayEnd, location: 0.38),
        .init(color: .sunnyDayEnd, location: 0.7),
        .init(color: .sunsetEnd, location: 0.78),
        .init(color: .midnightEnd, location: 0.82),
        .init(color: .midnightEnd, location: 1),
        ]
    
    let cloudTopStops: [Gradient.Stop] = [
        .init(color: .darkCloudStart, location: 0),
        .init(color: .darkCloudStart, location: 0.25),
        .init(color: .sunriseCloudStart, location: 0.33),
        .init(color: .lightCloudStart, location: 0.38),
        .init(color: .lightCloudStart, location: 0.7),
        .init(color: .sunsetCloudStart, location: 0.78),
        .init(color: .darkCloudStart, location: 0.82),
        .init(color: .darkCloudStart, location: 1),
    ]
    
    let cloudBottomStops: [Gradient.Stop] = [
        .init(color: .darkCloudEnd, location: 0),
        .init(color: .darkCloudEnd, location: 0.25),
        .init(color: .sunriseCloudEnd, location: 0.33),
        .init(color: .lightCloudEnd, location: 0.38),
        .init(color: .lightCloudEnd, location: 0.7),
        .init(color: .sunsetCloudEnd, location: 0.78),
        .init(color: .darkCloudEnd, location: 0.82),
        .init(color: .darkCloudEnd, location: 1),
        ]
    
    let starStops: [Gradient.Stop] = [
        .init(color: .white, location: 0),
        .init(color: .white, location: 0.25),
        .init(color: .clear, location: 0.33),
        .init(color: .clear, location: 0.38),
        .init(color: .clear, location: 0.7),
        .init(color: .clear, location: 0.78),
        .init(color: .white, location: 0.82),
        .init(color: .white, location: 1),
        ]
    
    var starOpacity: Double {
        let colour = starStops.interpolated(amount: time)
        return colour.getComponents().alpha
    }
    
    var body: some View {
        ZStack {
            StarView()
                .opacity(starOpacity)
            
            
            
            CloudsView(
                thickness: cloudThickness,
                topTint: cloudTopStops.interpolated(amount: time),
                bottomTint: cloudBottomStops.interpolated(amount: time)
            )
            
            SunView(progress: time)
            
            LightningView(maximumBolts: Int(lightningMaxBolts), forkProbability: Int(lightningForkProbability))
            
            if stormType != .none {
                StormView(type: stormType, direction: .degrees(rainAngle), strength: Int(rainIntensity))
            }
            
            WeatherDetailsView(tintColour: backgroundTopStops.interpolated(amount: time), residueType: stormType, residueStrength: rainIntensity)
        }
        
      
        
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [backgroundTopStops.interpolated(amount: time),backgroundBottomStops.interpolated(amount: time)], startPoint: .top, endPoint: .bottom)
        )
        .safeAreaInset(edge: .bottom){
            VStack {
                Button("Toggle Controls") {
                    withAnimation {
                        showingControl.toggle()
                    }
                }
                
                if showingControl {
                    VStack {
                        Text(formattedTime)
                            .padding(.top)
                        
                        Picker("Thickness", selection: $cloudThickness) {
                            ForEach(Cloud.Thickness.allCases, id: \.self) { thickness in
                                Text(String(describing: thickness).capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        HStack {
                            Text("Time:")
                            Slider(value: $time, in: 0...1)
                        }
                        .padding()
                        
                        Picker("Precipitation", selection: $stormType) {
                            ForEach(Storm.Contents.allCases, id: \.self) { stormType in
                                Text(String(describing: stormType).capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        HStack {
                            Text("Intensity")
                            Slider(value: $rainIntensity, in: 0...1000)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Angle:")
                            Slider(value: $rainAngle, in: 0...90)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Max Bolts")
                            Slider(value: $lightningMaxBolts, in: 0...10)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Fork %:")
                            Slider(value: $lightningForkProbability, in: 0...100)
                        }
                        .padding(.horizontal)
                    }
                    .transition(.move(edge:.bottom))
                }
            }
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
    }
    
    var formattedTime: String {
        let start = Calendar.current.startOfDay(for: Date.now)
        let advanced = start.addingTimeInterval(time * 24 * 60 * 60)
        return advanced.formatted(date: .omitted, time: .shortened)
    }
        
}

#Preview {
    ContentView()
}
