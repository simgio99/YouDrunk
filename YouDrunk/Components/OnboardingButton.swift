//
//  OnboardingButton.swift
//  YouDrunk
//
//  Created by Simone Giordano on 25/11/21.
//

import Foundation
import SwiftUI
struct OnboardingButton: View {
    
    // #1
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
    
    var body: some View {
        GeometryReader { proxy in
            LazyHStack {
                Button(action: {
                    
                    // #2
                    needsAppOnboarding = false
                }) {
                    Text("Let's start")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .font(Font.title2.bold().lowercaseSmallCaps())
                    .foregroundColor(.white)
                }
                .background(Color("PrimaryColor"))
                .foregroundColor(.black)
                .cornerRadius(40)
                .frame(minWidth: 0, maxWidth: proxy.size.width-40)
            }
            .frame(width: proxy.size.width, height: proxy.size.height/1.5)
        }
    }
}
