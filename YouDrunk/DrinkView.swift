//
//  DrinkView.swift
//  YouDrunk
//
//  Created by Simone Giordano on 15/11/21.
//

import SwiftUI


struct DrinkView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var drinkType: DrinkType!
    var drinkName: String!
    @State var mlQuantity = 330.0
    @State var drinkNum = 1
    @State var mlQuantityText: String!
    @State var insertDate = Date()
    @State var selectedDrink = CocktailList[0]
    @EnvironmentObject var drink_entries: DrinkEntryCollection
    @Environment(\.presentationMode) var presentationMode
    init(drink_type: DrinkType) {
        
        UITableView.appearance().backgroundColor = .clear
        drinkType = drink_type
        drinkName = Drink.drinkDictionary[drinkType] ?? ""
        
    }
    var body: some View {
        
            
        NavigationView {
            ZStack {
                
                VStack {
                    
                    Form {
                        Section {
                            Picker("Select your drink", selection: $selectedDrink) {
                                ForEach(DrinkList, id: \.self) {
                                    if($0.type == drinkType) {
                                        Text($0.drinkName)
                                    }
                                    
                                }
                            }
                            HStack {
                                Text("Drink Alcohol Percentage")
                                Spacer()
                                Text(String(format: "%.1f", selectedDrink.alcoholPercentage) + "%")
                            }
                        }
                    }
                        Text(drinkName)
                            .fontWeight(.semibold)
                            .font(.system(size: 38))
                        Spacer()
                        Image(drinkName)
                            .resizable()
                            .scaledToFill()
                            .frame(width:63, height:126)
                        Text(String(format: "%1.f", mlQuantity) + "ml")
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                            .foregroundColor(primary_color)
                            .padding()
                        Slider(value: $mlQuantity, in: 0...1000, step: 10)
                            .accentColor(primary_color)
                            .padding()
                        DatePicker("", selection: $insertDate)
                            .offset(x:-90)
                            .padding()
                        HStack(spacing:80) {
                            Button() {
                                drinkNum -= 1
                            }
                        label: {
                            ZStack {
                                
                                Circle()
                                    .frame(width: 50, height:50)
                                    .foregroundColor(backgroundNumber2)
                                Image(systemName: "minus")
                                    .foregroundColor(primary_color)
                            }
                        }
                            Text("\(drinkNum)")
                                .font(.system(size:28))
                            Button() {
                                drinkNum += 1
                            }
                        label: {
                            ZStack {
                                Circle()
                                    .frame(width: 50, height:50)
                                    .foregroundColor(backgroundNumber2)
                                Image(systemName: "plus"
                                )
                                    .foregroundColor(primary_color)
                            }
                        }
                        }.padding()
                        Spacer()
                        Button() {
                            addDrink(drink:selectedDrink, date: insertDate)
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width:104, height:50)
                                .foregroundColor(primary_color)
                            
                            Text("+ " + self.drinkName)
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                            }
                        }
                        
                        
                        
                        
                        
                    
                }
                .background(Color.white)
                
                    .navigationTitle("Add Drink")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            }
                            label : {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(primary_color)
                            }
                        }
                        
                }
            }
                
        }
    }
    
    func addDrink(drink: Drink, date: Date) {
        let drink_entry = DrinkEntry(drink: drink, date: date)
        print("DIO MERDA GUARDA QUi")
        print(drink_entry.drink.alcoholPercentage)
        drink_entries.drinkentries.append(drink_entry)
        
        print(drink_entries.drinkentries[0].drink.alcoholPercentage)
    }
}

struct DrinkView_Previews: PreviewProvider {
   
    static var previews: some View {
        DrinkView(drink_type: DrinkType.Cocktail)
    }
}
