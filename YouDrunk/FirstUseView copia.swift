import SwiftUI

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil,
        from: nil,
        for: nil)
  }
}

struct FirstUseView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @AppStorage ("userGender") var selectedGender = 0
    @AppStorage ("userAge") var userAge = 20
    @AppStorage ("userWeight") var userWeight = 70
    @AppStorage ("userConfigured") var userConfigured = false
    @State private var appStateSetup = "App NOT setup"
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding:Bool = true
    @Environment(\.route) private var route: Binding<Route>
    
//    init(){
//            UITableView.appearance().backgroundColor = .clear
//        }
    
    var body: some View {
        mainView.onAppear{
            if !needsAppOnboarding {
                appStateSetup = "App Setup"
            }
        }
    }
}

extension FirstUseView{
    private var mainView: some View {
        NavigationView {
            VStack {
                Form {
                    Section(
                        header: Text("Sex")
                                .fontWeight(.bold),
                    footer: Text("The choice is restricted to these two options as the alcohol rate calculation algorithm is based on the metabolism of males and females")) {
                        Picker("What is your favorite color?", selection: $selectedGender) {
                            Text("Male").tag(0)
                            Text("Female").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text ("Weight").fontWeight(.bold)) {
                        TextField("Weight (kg)", value: $userWeight, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }

                    Section(header: Text("Age")
                                .fontWeight(.bold)) {
                        TextField("Age", value: $userAge, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }
                Button {
                    needsAppOnboarding = true
                } label: {
                    Text("Reset Onboarding")
                }
                .sheet(isPresented: $needsAppOnboarding) {
                    OnboardingSheetView()
                }
                .onChange(of: needsAppOnboarding) { needsAppOnboarding in
                    if !needsAppOnboarding {
                        appStateSetup = "App Setup"
                    }
                }
                PrimaryButton(button_text: "Let's Drink", route_val: Route.home)
            }
            .onTapGesture {
                  self.endTextEditing()
            }
//            .background(background_color)
            .navigationTitle("Enter your information")
        }
    }
}

struct OnboardingSheetView: View{
    var body: some View{
        Spacer()
        VStack {
            Text("What's in YouDrunk")
                .font(.largeTitle)
            OnboardingTexts(imageNameOnboarding: "clock.arrow.circlepath",
                            textTitle: "Check yourself",
                            textCaption: "Real-time monitoring of your alcohol content"
            )
            
            OnboardingTexts(imageNameOnboarding: "person.fill.checkmark",
                            textTitle: "Be safe",
                            textCaption: "Discover when it's truly safe to drive for you"
            )
            
            OnboardingTexts(imageNameOnboarding: "exclamationmark.triangle",
                            textTitle: "Don't panic",
                            textCaption: "Push the button and call for some help        "
            )
        }
        Spacer()
        OnboardingSheetButton(button_text: "Let's Go")
        Spacer()
    }
}

struct OnboardingTexts: View {
    
    @State var imageNameOnboarding: String
    @State var textTitle: String
    @State var textCaption: String
    
    var body: some View{
        HStack{
            Image(systemName: imageNameOnboarding)
            
            VStack(alignment: .leading) {
                Text(textTitle)
                    .font(.title3)
                Text(textCaption)
                    .fontWeight(.light)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
        .padding(.horizontal, 50)
    }
}

struct OnboardingSheetButton: View {
    
    var button_text: String = ""
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding:Bool = true
    
    var body: some View{
        Button {
            needsAppOnboarding = false
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width:104, height:50)
                    .foregroundColor(primary_color)
                
                Text(button_text)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                }
            }
        }
    }

struct FirstUseView_Previews: PreviewProvider {
    static var previews: some View {
//        FirstUseView()
        OnboardingSheetView()
    }
}
