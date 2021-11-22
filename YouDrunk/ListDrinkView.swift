//
//  ListDrinkView.swift
//  YouDrunk
//
//  Created by Danilo Sequino on 20/11/21.
//

import SwiftUI

struct ListDrinkView: View {
    
    @FetchRequest(
        entity: CoreDrinkEntry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_date, ascending: false),
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_alcohol, ascending: false)
        ]
    ) var drinkEntries: FetchedResults<CoreDrinkEntry>
    @State var drink_entries = DrinkEntryCollection()
    
    var body: some View {
        VStack {
            TabView {
                    drinkScrollView(imageName: "Beer", buttonName: "Beer", drinkType: DrinkType.Beer)
                    drinkScrollView(imageName: "Cocktail", buttonName: "Cocktail",drinkType: DrinkType.Cocktail)
                    drinkScrollView(imageName: "Long Drink", buttonName: "Long Drink", drinkType: DrinkType.LongDrink)
                    drinkScrollView(imageName: "White Wine", buttonName: "White Wine", drinkType: DrinkType.WhiteWine)
                    drinkScrollView(imageName: "Red Wine", buttonName: "Red Wine", drinkType: DrinkType.RedWine)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .environmentObject(drink_entries)
        }
    }
}

struct drinkScrollView: View {
    @State var imageName: String
    @State var buttonName: String
    @State private var showingModal = false
    var drinkType : DrinkType
    
    var body: some View {
        Button {
            showingModal = true
            }
            label:{
                VStack {
                    Spacer()
                    Text(buttonName)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                    Spacer()
                    Image("\(imageName)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    Spacer()
                }
            }
            .sheet(isPresented: $showingModal) {
            DrinkView(drink_type: drinkType)
        }
    }
}

struct ListDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        ListDrinkView()
    }
}
