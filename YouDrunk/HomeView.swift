import SwiftUI
import CoreData

class ObservableBool: ObservableObject {
    @Published var condition: Bool = false
    
}

struct HomeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var drink_entries = DrinkEntryCollection()
    init() {
        CDManager.getInstance().wipe("CoreDrink")
        CDManager.getInstance().save()
    }
    
    @State var isTappedStats: Bool = false
    @State var gramsPerLiter: String = "0,0 g/L"
    @State var alcoholPercentage: String = "0%"
    @State var soberTime: String = "0.0 hours"
    @State var isTappedFullStomach = false
    @State var showModal = false
    @State var showPanic = false
    @State var showingAccountView = false
    @State var currentAlcohol = 0.0
    @FetchRequest(
        entity: CoreDrinkEntry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_date, ascending: false),
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_alcohol, ascending: false)
        ]
    ) var drinkEntries: FetchedResults<CoreDrinkEntry>
    @AppStorage ("userGender") var selectedGender = 0
    @AppStorage ("fullStomach") var fullStomach = false
    @AppStorage ("userAge") var userAge = 20
    @AppStorage ("userWeight") var userWeight = 70
    let timer = Timer.publish(every: 10,
                              on: .main,
                              in: .common).autoconnect()
    @ObservedObject var showingDrinkView = ObservableBool()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("", destination: NewDrinkView(drinkType: DrinkType.Cocktail), isActive: $showingDrinkView.condition)
            
                NavigationLink("", destination: AccountView(), isActive: $showingAccountView)
                    statusColumn(currentAlcohol: $currentAlcohol)
            }
            .navigationTitle("My Status")
            .navigationViewStyle(.stack)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingAccountView = true
                    }
                    label : {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(primary_color)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingDrinkView.condition = true
                    }
                    label : {
                        Image(systemName: "plus")
                            .foregroundColor(primary_color)
                    }
//                    .sheet(isPresented: $showingDrinkView) {
//                        NewDrinkView()
//                    }
                }
            }
        }
        .environmentObject(showingDrinkView)
    }
}

struct statusColumn:View {
    
    @State var isTappedStats: Bool = false
    @State var gramsPerLiter: String = "0,0 g/L"
    @State var alcoholPercentage: String = "0%"
    @State var soberTime: String = "2.5 hours"
    @State var isTappedFullStomach = false
    @State var heigthBar: CGFloat = 1
    @State var isAnimated: Bool = false
    
    @Binding var currentAlcohol: Double
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
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
    
    let today = Date.now
    
    var repeatingAnimation: Animation {
        Animation
            .easeInOut(duration: 2)
            .repeatForever()
    }
    
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
                        .padding(.horizontal, 34)
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
                    Text("Today consumptions:")
                        .bold()
                        .padding()
                        .padding()
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
            alcoholSum += drink_contribute / Float(cConst) - reduction
            
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
