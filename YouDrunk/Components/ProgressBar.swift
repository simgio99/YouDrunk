//
//  ProgressBar.swift
//  YouDrunk
//
//  Created by Simone Giordano on 25/11/21.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color("PrimaryColor"))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(1.0 - self.progress / 4.0, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("PrimaryColor"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut)

        }
    }
}
