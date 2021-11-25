//
//  StatusColumn.swift
//  YouDrunk
//
//  Created by Simone Giordano on 25/11/21.
//

import SwiftUI

struct statusColumn : View {
    
    @State var isTappedStats: Bool = false
    @AppStorage ("gramsPerLiter") var gramsPerLiter: String = "0,0 g/L"
    @AppStorage ("alcoholPercentage") var alcoholPercentage: String = "0%"
    @AppStorage ("soberTime") var soberTime: String = "0.0 hours"
    @State var isTappedFullStomach = false
    @State var heigthBar: CGFloat = 1
    @State var isAnimated: Bool = false
    @State var todayDrinkExist: Bool = false
    @Binding var currentAlcohol: Double
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @AppStorage ("userWeight") var userWeight = 70
    @AppStorage ("fullStomach") var fullStomach = false
    @AppStorage ("userGender") var selectedGender = "Male"
    @FetchRequest(
        entity: CoreDrinkEntry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_date, ascending: false),
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_alcohol, ascending: false)
        ]
        
    ) var drinkEntries: FetchedResults<CoreDrinkEntry>
    @FetchRequest(
        entity: CoreDrinkEntry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_date, ascending: false),
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_alcohol, ascending: false)
            
        ],
        predicate: NSPredicate(format: "drink_date == %@", Date() as NSDate)
        
    ) var drinkToday: FetchedResults<CoreDrinkEntry>
    @State var progressValue: Float = 0.0
    let today = Date.now
    
    var repeatingAnimation: Animation {
        Animation
            .easeInOut(duration: 2)
            .repeatForever()
    }
    @ObservedObject var showingDrinkView = ObservableBool()
    
    var body: some View{
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .frame(height:150)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(backgroundNumber2)
            VStack {
                Text("Alcohol Percentage")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .padding()
                    .padding(.horizontal, -150)
                HStack(spacing:120) {
                    Text(alcoholPercentage)
                        .foregroundColor(primary_color)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 50)
                    Text(gramsPerLiter)
                        .foregroundColor(.black)
                }
            }
        }
        
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .frame(height:150)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(backgroundNumber2)
                .onReceive(timer) {_ in
                    updateCurrentAlcohol()
                }
            HStack {
                VStack {
                    VStack(alignment: .leading){
                        Text("Sober in:")
                            .bold()
                            .padding()
                            .padding()
                        Text(soberTime)
                            .font(.title)
                            .bold()
                            .foregroundColor(primary_color)
                            .padding(.horizontal, 30)
                    }
                }
                VStack {
                    ProgressBar(progress: self.$currentAlcohol)
                        .frame(width: 100.0, height: 100.0)
                        .padding(40.0)
                    
                }
            }
        }
        
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .frame(height:250)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(backgroundNumber2)
                .onReceive(timer) {_ in
                    updateCurrentAlcohol()
                }
            VStack {
                VStack(alignment: .leading){
                    Text("Today consumptions")
                        .bold()
                        .padding(.vertical, 40)
                        .padding(.horizontal, 50)
                        
                    if(drinkEntries.count == 0) {
                        Image(systemName: "eyes")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.vertical, -15)
                            .padding(.horizontal, 100)
                            .foregroundColor(Color("PrimaryColor"))
                            .onTapGesture {
                                showingDrinkView.condition = true
                            }
                            
                        Text("You didn't drink anything today")
                            .fontWeight(.semibold)
                            .padding(.horizontal,50)
                            .padding(.vertical, 20)
                    }
                    else {
                        VStack(spacing: 5) {
                            
                            ScrollView {
                                ForEach(drinkEntries, id: \.self) { drink in
                                    if(Calendar.current.isDateInToday(drink.drink_date!)) {
                                    HStack {
                                        Image(Drink.drinkDictionary[DrinkType(rawValue: drink.drink_type)!]!)
                                            .resizable()
                                            .frame(width: 20, height: 35)
                                            .scaledToFill()
                                        Spacer()
                                        Text(drink.drink_name ?? "?")
                                            .font(.headline)
                                        Spacer()
                                        Text("\(drink.drink_mls) ml")
                                    }
                                    .padding(.horizontal,50)
                                    }
                                }
                            }
                            .frame(maxHeight: 150)
                        }
                        .padding(.vertical, -5)
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
        Spacer()
    }
    func incrementHeigth(amount:CGFloat) {
        withAnimation(.easeInOut) {
            heigthBar += amount
        }
    }
    
    func updateCurrentAlcohol() {
        
        var alcoholSum: Float = 0.0
        
        var cConst = 0.0
        
        for drink in drinkEntries {
            
            let diffComponents = Calendar.current.dateComponents([.minute], from: drink.drink_date ?? Date.now, to: Date.now)
            let minutes = diffComponents.minute ?? 0
            
            if(drink.drink_date ?? Date.now > Date.now) {
                continue
            }
            if (minutes > Int(4.0 / 0.15 * 60)) {
                break
            }
            let full_stomach = drink.full_stomach
            if selectedGender == "Male" && full_stomach {
                print(selectedGender)
                cConst = 1.2
            }
            else if selectedGender == "Male" && !full_stomach {
                print(selectedGender)
                cConst = 0.7
            }
            else if selectedGender == "Female" && full_stomach {
                print(selectedGender)
                cConst = 0.9
            }
            else if selectedGender == "Female" && !full_stomach {
                print(selectedGender)
                cConst = 0.5
            }
            let drink_contribute = Float((Float(drink.drink_mls) / 1000) * (drink.drink_alcohol * 8) / Float(userWeight))
            let reduction = Float(0.15 / 60 * Float(minutes))
            alcoholSum += max(drink_contribute / Float(cConst) - reduction, 0)
            
        }
        currentAlcohol = Double(alcoholSum)
        gramsPerLiter = String(format: "%.1f", currentAlcohol) + "g/l"
        alcoholPercentage = "\(Int(currentAlcohol / 4.0 * 100))%"
        
        heigthBar = currentAlcohol / 4.0 * 500
        
        let soberTimeNum = currentAlcohol / (Drink.drinkMethabolismRatePerMinute * 60)
        soberTime = String(format: "%.1f", soberTimeNum) + "hours"
    }
    
    func animateBar(_ height: CGFloat) {
        if heigthBar == 1 {
            withAnimation(.easeInOut(duration: 1.5)) {
                heigthBar += height
                isAnimated = true
                if isAnimated {
                    withAnimation(self.repeatingAnimation) {
                        heigthBar += 25
                    }
                }
            }
        }
    }
}

