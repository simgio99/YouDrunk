import SwiftUI
import CoreData

struct StatusRectangle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 26)
            .frame(width: 157, height:105)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standard = UINavigationBarAppearance()
        standard.backgroundColor = UIColor(background_color) //When you scroll or you have title (small one)
        
        let compact = UINavigationBarAppearance()
        compact.backgroundColor = UIColor(background_color) //compact-height
        
        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.backgroundColor = UIColor(background_color) //When you have large title
        
        navigationBar.standardAppearance = standard
        navigationBar.compactAppearance = compact
        navigationBar.scrollEdgeAppearance = scrollEdge
    }
}

struct HomeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @State var drink_entries = DrinkEntryCollection()
    init() {
        UITableView.appearance().backgroundColor = UIColor(background_color)
        
        CDManager.getInstance().wipe("CoreDrink")
 
        CDManager.getInstance().save()
    }
    
    @State var isTappedStats: Bool = false
    @State var gramsPerLiter: String = "0,0 g/L"
    @State var alcoholPercentage: String = "0%"
    @State var soberTime: String = "2.5 hours"
    @State var isTappedFullStomach = false
    @State var showModal = false
    @State var showingAccountView = false
    @State var currentAlcohol = 25.0
    @FetchRequest(
        entity: CoreDrinkEntry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_date, ascending: false),
            NSSortDescriptor(keyPath: \CoreDrinkEntry.drink_alcohol, ascending: false)
        ]
    ) var drinkEntries: FetchedResults<CoreDrinkEntry>
    @AppStorage ("userGender") var selectedGender = 0
    @AppStorage ("userAge") var userAge = 20
    @AppStorage ("userWeight") var userWeight = 70
    let timer = Timer.publish(every: 10,
                              on: .main,
                              in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {

                NavigationLink("", destination: StatsView(), isActive: $isTappedStats)
                NavigationLink("", destination: AccountView(), isActive: $showingAccountView)
                TabView{
                    statusColumn(currentAlcohol: $currentAlcohol)
                    statusColumn(currentAlcohol: $currentAlcohol)
                }
                .tabViewStyle(.page)
                
                ScrollView(.horizontal) {
                    HStack {
                        drinkScrollView(imageName: "Beer", buttonName: "Beer", drinkType: DrinkType.Beer)
                        drinkScrollView(imageName: "Cocktail", buttonName: "Cocktail",drinkType: DrinkType.Cocktail)
                        drinkScrollView(imageName: "Long Drink", buttonName: "Long Drink", drinkType: DrinkType.LongDrink)
                        drinkScrollView(imageName: "White Wine", buttonName: "White Wine", drinkType: DrinkType.WhiteWine)
                        drinkScrollView(imageName: "Red Wine", buttonName: "Red Wine", drinkType: DrinkType.RedWine)
                    }
                    .environmentObject(drink_entries)
                    
                }
                .background(backgroundNumber2)
                .padding(0)
                .offset(y:40)
            }
            .navigationTitle("My Status")
            .navigationViewStyle(.stack)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAccountView = true
                    }
                    label : {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(primary_color)
                    }
                }
            }
            
        }
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
        //left bar
        HStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width:50, height: 500)
                    .foregroundColor(backgroundNumber2)
                
                RoundedRectangle(cornerRadius: 16)
                    .frame(width:50, height: 1 + heigthBar)
                    .foregroundColor(primary_color)
                    
            }
            .onReceive(timer) {_ in
                updateCurrentAlcohol()
                
            }
            .onAppear {
                animateBar(heigthBar)
            }
            Spacer()
                .frame(width:110)
            
            //Big, grey rectangle
            VStack {
                Spacer()
                    .frame(height:50)
                
                //stats rectangle
                ZStack {
                    StatusRectangle()
                        .shadow(color: .gray, radius: 4.0, x: 0.0, y: 2.0)
                        .onTapGesture {
                            isTappedStats = true
                        }
                    VStack(alignment: .leading) {
                        Text(today.formatted(date: .abbreviated, time: .omitted))
                            .foregroundColor(.black)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                        Text("")
                        Text(gramsPerLiter)
                            .foregroundColor(primary_color)
                        Text(alcoholPercentage)
                            .foregroundColor(primary_color)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .shadow(color: .gray, radius: 7, x: 0, y: 1)
                    }
                }
                Spacer()
                    .frame(height:50)
                
                //sober in:... rectangle
                ZStack {
                    StatusRectangle()
                    VStack(alignment: .leading){
                        Text("Sober in:")
                            .bold()
                        Text(soberTime)
                            .font(.title)
                            .bold()
                            .foregroundColor(primary_color)
                    }
                }
                Spacer()
                    .frame(height:50)
                
                //full stomach rectangle
                ZStack {
                    StatusRectangle()
                        .shadow(color: .gray, radius: 4.0, x: 0.0, y: 2.0)
                    Text("Full Stomach")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .padding(.all)
                        .foregroundColor(isTappedFullStomach ? primary_color : .gray)
                        .onTapGesture {
                            isTappedFullStomach.toggle()
                            
                        }
                }
                Spacer()
                    .frame(height:50)
            }
            .background(backgroundNumber2)
            .clipShape(RoundedRectangle(cornerRadius:20))
        }
    }
    func incrementHeigth(amount:CGFloat) {
        withAnimation(.easeInOut) {
            heigthBar += amount
        }
    }
    
    func updateCurrentAlcohol() {
        
        var alcoholSum: Float = 0.0
        for drink in drinkEntries {
            let diffComponents = Calendar.current.dateComponents([.minute], from: drink.drink_date ?? Date.now, to: Date.now)
            let minutes = diffComponents.minute ?? 0
            
            if (minutes > Int(4.0 / 0.15 * 60)) {
                break
            }
            let drink_contribute = Float((Float(drink.drink_mls) / 1000) * (drink.drink_alcohol * 8) / (1.2 * Float(userWeight))) - Float(0.15 / 60 * Float(minutes))

            alcoholSum += drink_contribute
            
        }
        currentAlcohol = Double(alcoholSum)
        gramsPerLiter = String(format: "%.1f", currentAlcohol) + "g/l"
        alcoholPercentage = "\(Int(currentAlcohol / 4.0 * 100))%"
        print(currentAlcohol)
        heigthBar = currentAlcohol / 4.0 * 500
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

struct drinkScrollView: View {
    
    @State var imageName: String
    @State var buttonName: String
    @State private var showingModal = false
    var drinkType : DrinkType
    
    var body: some View {
        VStack(spacing: -5) {
            ZStack {
                Button {
                    showingModal = true
                }
                
            label:
                {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width:59, height:59)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                        Image("\(imageName)")
                    }
                }
                .sheet(isPresented: $showingModal) {
                    DrinkView(drink_type: drinkType)
                }
            }
            Text("\(buttonName)")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .padding(.bottom,10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
