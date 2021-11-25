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
        ],
        predicate: NSPredicate(format: "drink_date < %@", Date.now as NSDate)
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





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
