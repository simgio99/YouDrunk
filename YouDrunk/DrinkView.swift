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
    @State var fullStomach: Bool = false
    @EnvironmentObject var drink_entries: DrinkEntryCollection
    @EnvironmentObject var showingDrinkView: ObservableBool
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
                      
                    
                        Spacer(minLength: 60)
                        
                        Image(drinkName)
                    
                            .resizable()
                            .scaledToFill()
                            .frame(width:63, height:126)
                    Form {
                        Section {
                            Picker("Select your drink", selection: $selectedDrink) {
                                ForEach(DrinkList, id: \.self) {
                                    if($0.type == drinkType) {
                                        Text($0.drinkName)
                                    }
                                }
                            }.font(.headline)
                            HStack {
                                Text("Drink Alcohol Percentage")
                                Spacer()
                                Text(String(format: "%.1f", selectedDrink.alcoholPercentage) + "%")
                            }
                            HStack{
                                Text("Have you eaten?")
                                Toggle(isOn: self.$fullStomach){
                                    
                                }
                            }
                        }
                    }
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
                }
                .background(Color.white)
                .navigationTitle("Add " + drinkName)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        }
                        label : {
                            Image(systemName: "x.circle")
                                .foregroundColor(primary_color)
                            }
                        }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addDrink(drink:selectedDrink, date: insertDate, mls: Int(mlQuantity) * drinkNum, fullStomach: self.fullStomach)
                            showingDrinkView.condition = false
                            presentationMode.wrappedValue.dismiss()
                        }
                        label : {
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(primary_color)
                            }
                        }
                }
            }
                
        }
    }
    
    func addDrink(drink: Drink, date: Date, mls: Int, fullStomach: Bool) {
        let drink_entry = DrinkEntry(drink: drink, date: date, mlQuantity: mls)
        print("DIO MERDA GUARDA QUi")
        print(drink_entry.drink.alcoholPercentage)
        
        let coreDrink = CoreDrinkEntry(context: CDManager.getInstance().dataContainer.viewContext)
        coreDrink.drink_name = drink.drinkName
        coreDrink.drink_alcohol = drink.alcoholPercentage
        coreDrink.drink_type = drink.type.rawValue
        coreDrink.drink_date = date
        coreDrink.drink_mls = Int32(mls)
        coreDrink.full_stomach = fullStomach
        
    }
}

struct DrinkView_Previews: PreviewProvider {
   
    static var previews: some View {
        DrinkView(drink_type: DrinkType.Cocktail)
    }
}
