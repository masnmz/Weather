//
//  LightningView.swift
//  Weather
//
//  Created by Mehmet Alp Sönmez on 08/01/2025.
//

import SwiftUI

struct LightningView: View {
    var lightning: Lightning

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                lightning.update(date: timeline.date, in: size)
                
                let fullScreen = Path(CGRect(origin: .zero, size: size))
                context.fill(fullScreen, with: .color(.white.opacity(lightning.flashOpacity)))
                
                for _ in 0..<2 {
                    
                    for bolt in lightning.bolts {
                        var path = Path()
                        path.addLines(bolt.points)
                        context.stroke(path, with: .color(.white), lineWidth: bolt.width)
                    }
                    context.addFilter(.blur(radius: 5))
                }
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            lightning.strike()
        }
    }

    init(maximumBolts: Int = 4, forkProbability: Int = 20) {
        lightning = Lightning(maximumBolts: maximumBolts, forkProbability: forkProbability)
    }
}

#Preview {
    LightningView()
}
