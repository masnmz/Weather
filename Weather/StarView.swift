//
//  StarView.swift
//  Weather
//
//  Created by Mehmet Alp Sönmez on 02/01/2025.
//

import SwiftUI

struct StarView: View {
    @State var starField = StarField()
    
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timeInterval = timeline.date.timeIntervalSince1970
                starField.update(date: timeline.date)
                context.addFilter(.blur(radius: 0.3))
                for (index,star) in starField.stars.enumerated() {
                    let path = Path(ellipseIn: CGRect(x: star.x, y: star.y, width: star.size, height: star.size))
                    
                    if star.flickerInterval == 0 {
//                        flashing star
                        var flashLevel = sin(Double(index) + timeInterval * 4)
                        flashLevel = abs(flashLevel)
                        flashLevel /= 2
                        context.opacity = 0.5 + flashLevel
                    } else {
//                        blooming star
                        var flashLevel = sin(Double(index) + timeInterval)
//                        Flash level = -1 to 1
//                        If we multiply that by flicker interval, which is 3 to 20
//                        Then: flashLevel will be -3 to 3 on the low end, up to -20 to 20 on the high end
//                        Then: take away flashLevel - 1 (19) - 39 to 1
                        
                        flashLevel *= star.flickerInterval
                        flashLevel -= star.flickerInterval - 1
                        
                        if flashLevel > 0 {
                            var contextCopy = context
                            contextCopy.addFilter(.blur(radius: 3))
                            contextCopy.fill(path, with: .color(white: 1))
                            contextCopy.fill(path, with: .color(white: 1))
                            contextCopy.fill(path, with: .color(white: 1))
                          
                        }
                        
                        context.opacity = 1
                    }
                    
                    if index.isMultiple(of: 5) {
                        context.fill(path, with: .color(red: 1, green: 0.6, blue: 0.7))
                    } else {
                        context.fill(path, with: .color(white: 1))
                        
                    }
                }
            }
        }
        .ignoresSafeArea()
        .mask (
            LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    StarView()
}
