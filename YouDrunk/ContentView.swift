import SwiftUI

let primary_color = Color("PrimaryColor")
let background_color = Color("BackgroundColor")
let backgroundNumber2 = Color("BackgroundNumber2")
let panic_color = Color("Panic")

enum Route: String {
//    case onboarding
    case userconfig
    case home
}

struct RouteKey: EnvironmentKey {
    static var defaultValue: Binding<Route> =
    Binding.constant(Route.userconfig)
}

extension EnvironmentValues {
    var route: Binding<Route> {
        get { self[RouteKey.self] }
        set { self[RouteKey.self] = newValue }
    }
}

struct PrimaryButton: View {
    
    @Environment(\.route) private var route: Binding<Route>
    var button_text: String = ""
    var next_view: AnyView!
    var route_val: Route!
    
    var body: some View {
        Button {
            withAnimation {
                route.wrappedValue = route_val
            }
        }
        
    label: {
        ZStack {
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

struct OnboardingView: View {
    
    @Environment(\.route) private var route: Binding<Route>
    @State private var appStateSetup = "App NOT setup"
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding:Bool = true
    
    var body: some View {
        VStack {
            Spacer(minLength: 150)
            Text("What's in YouDrunk")
                .font(Font.largeTitle.bold().lowercaseSmallCaps())
                .multilineTextAlignment(.center)
                .foregroundColor(Color("PrimaryColor"))
            Spacer(minLength: 60)
            
            HStack {
                Image(systemName: "lasso.and.sparkles")
                    .resizable()
                    .frame(width:35, height: 35)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Add your drinks")
                        .font(.headline.bold())
                    Text("Select your preferred beverage           ")
                }
            }
            .foregroundColor(Color("PrimaryColor"))
            Spacer(minLength: 30)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width:35, height: 35)
                    .padding()
        
                VStack(alignment: .leading) {
                    Text("Know yourself")
                        .font(.headline.bold())
                    Text("Check your alcohol usage in real time")
                }
            }
            .foregroundColor(Color("PrimaryColor"))
            Spacer(minLength: 30)
            
            HStack {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width:35, height: 35)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Be safe      ")
                        .font(.headline.bold())
                    Text("Know when it's time to stop drinking  ")
                }
            }
            .foregroundColor(Color("PrimaryColor"))

                    OnboardingButton()
                }
                .background(Color("BackgroundColor"))
                .foregroundColor(.white)
                .ignoresSafeArea(.all, edges: .all)
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @AppStorage("onboardingNeeded") private var onboardingNeeded = true
    @AppStorage("alcohol") var currentAlcohol = 0.0
    @State @AppStorage("showUserConfig") var showUserConfig = false 
    @State @AppStorage("showOnboarding") var showOnboarding = true
    @AppStorage("route") var route = Route.userconfig
    
    var body: some View {
        
        switch route {
//        case .onboarding:
//            OnboardingView().environment(\.route, $route)
//                .transition(.opacity)
            
        case .userconfig:
            FirstUseView().environment(\.route, $route)
                .transition(.opacity)
            
        case .home:
            HomeView().environment(\.route, $route)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
