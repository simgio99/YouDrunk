//
//  NewDrinkView.swift
//  YouDrunk
//
//  Created by Danilo Sequino on 22/11/21.
//

import SwiftUI

struct NewDrinkView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var mlQuantity = 330.0
    @State var drinkNum = 1
    @State var mlQuantityText: String!
    @State var insertDate = Date()
    @State var selectedDrink = CocktailList[0]
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var showingDrinkView: ObservableBool
    @State var newSelectedDrink: String = ""
    let text_image_drinks: [String] = [
        "Beer", "Cocktail", "Long Drink", "White Wine", "Red Wine"
    ]
    @State private var showingSheet = false
    @State var drinkType: DrinkType
    
    var body: some View {
        NavigationView{
            Form {
                tabDrinks(text_image: "Beer", drinkType: DrinkType.Beer)
                        .onTapGesture {
                            self.drinkType = DrinkType.Beer
                            showingSheet.toggle()
                        }
                       
                
                tabDrinks(text_image: "Cocktail", drinkType: DrinkType.Cocktail)
                        .onTapGesture {
                            self.drinkType = DrinkType.Cocktail
                            showingSheet.toggle()
                        }
                
                tabDrinks(text_image: "Long Drink", drinkType: DrinkType.LongDrink)
                        .onTapGesture {
                            self.drinkType = DrinkType.LongDrink
                            showingSheet.toggle()
                        }
                
                tabDrinks(text_image: "Red Wine", drinkType: DrinkType.RedWine)
                        .onTapGesture {
                            self.drinkType = DrinkType.RedWine
                            showingSheet.toggle()
                        }
                
                tabDrinks(text_image: "White Wine", drinkType: DrinkType.WhiteWine)
                        .onTapGesture {
                            self.drinkType = DrinkType.WhiteWine
                            showingSheet.toggle()
                        }
            }
            .sheet(isPresented: $showingSheet) {
                DrinkView(drink_type: self.drinkType)
                    
            }
            Spacer()
        }
        .navigationTitle("Select Drink Type")
        .environmentObject(showingDrinkView)
    }
}
    

struct NewDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        NewDrinkView(drinkType: DrinkType.Cocktail)
    }
}
