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
        NavigationView {
            VStack(spacing: 2) {
                Image("YouDrunk_Logo")
                    .resizable()
                    .scaledToFill()
                    .offset(y:-30)

                Text("Welcome to YouDrunk ")
                    .font(.system(size: 24))
                    .fontWeight(.bold)

                Text("Here by adding your characteristics and your daily consumptions you can keep track of the alcohol level in your body in real time.")
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .padding()

                PrimaryButton(button_text: "Start", route_val: Route.userconfig)
            }
        }
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
