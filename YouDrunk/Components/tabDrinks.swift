//
//  tabDrinks.swift
//  YouDrunk
//
//  Created by Simone Giordano on 25/11/21.
//

import Foundation
import SwiftUI
struct tabDrinks: View {
    
    @State var text_image: String = ""
    var drinkType: DrinkType
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                HStack{
                    Image("\(text_image)")
                        .resizable()
                        .frame(width: 20, height: 35)
                        .padding(.horizontal)
                    Text("\(text_image)")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .font(.title3)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
        }
    }
}
