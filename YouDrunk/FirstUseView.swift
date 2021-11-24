//
//  FirstUseView.swift
//  YouDrunk
//
//  Created by Simone Giordano on 12/11/21.
//

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
    @AppStorage ("userGender") var selectedGender = "Male"
    @AppStorage ("userAge") var userAge = 20
    @AppStorage ("userWeight") var userWeight = 70
    @AppStorage ("userConfigured") var userConfigured = false
    @Environment(\.route) private var route: Binding<Route>
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    @State private var appSetupState = "App NOT setup ☹️"
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    var body: some View {

        
        mainView.onAppear {
                    
                    if !needsAppOnboarding {
                        NavigationView {
                            VStack {
                                Form {
                                    Section(header: Text("Sex")
                                                .fontWeight(.bold)) {
                                        Picker("What is your favorite color?", selection: $selectedGender) {
                                            Text("Male").tag("Male")

                                            Text("Female").tag("Female")


                                        }

                                        .pickerStyle(SegmentedPickerStyle())

                                    }
                                    Section(header: Text ("Weight")
                                                .fontWeight(.bold)) {

                                        TextField("Weight (kg)", value: $userWeight, formatter: NumberFormatter())
                                            .keyboardType(.numberPad)
                                    }
                                    Section(header: Text("Age")
                                                .fontWeight(.bold)) {
                                        TextField("Age", value: $userAge, formatter: NumberFormatter())
                                            .keyboardType(.numberPad)
                                    }


                                }
                                
                                PrimaryButton(button_text: "Let's Drink", route_val: Route.home)

                            }
                            .onTapGesture {
                                  self.endTextEditing()
                            }
                            .background(background_color)
                            .navigationTitle("Enter your information")
                        }
                    }
                }
        
    }
}

extension FirstUseView {
    
    private var mainView: some View {
        VStack {
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Sex")
                                    .fontWeight(.bold)) {
                            Picker("What is your favorite color?", selection: $selectedGender) {
                                Text("Male").tag("Male")

                                Text("Female").tag("Female")


                            }

                            .pickerStyle(SegmentedPickerStyle())

                        }
                        Section(header: Text ("Weight")
                                    .fontWeight(.bold)) {

                            TextField("Weight (kg)", value: $userWeight, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        Section(header: Text("Age")
                                    .fontWeight(.bold)) {
                            TextField("Age", value: $userAge, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                    }
                    PrimaryButton(button_text: "Let's Drink", route_val: Route.home)
//                    Button(action: {
//                        needsAppOnboarding = true
//                    }) {
//                        Text("Reset Onboarding")
//                        .padding(.horizontal, 40)
//                        .padding(.vertical, 15)
//                        .font(Font.title2.bold().lowercaseSmallCaps())
//                    }
//                    .background(Color.black)
//                    .foregroundColor(.white)
//                    .cornerRadius(40)

                }
                .onTapGesture {
                      self.endTextEditing()
                }
                .background(background_color)
                .navigationTitle("Enter your information")
            }
            .sheet(isPresented:$needsAppOnboarding) {
                OnboardingView()
            }
        }
    }
}

struct OnboardingButton: View {
    
    // #1
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
    
    var body: some View {
        GeometryReader { proxy in
            LazyHStack {
                Button(action: {
                    
                    // #2
                    needsAppOnboarding = false
                }) {
                    Text("Let's start")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .font(Font.title2.bold().lowercaseSmallCaps())
                    .foregroundColor(.white)
                }
                .background(Color("PrimaryColor"))
                .foregroundColor(.black)
                .cornerRadius(40)
                .frame(minWidth: 0, maxWidth: proxy.size.width-40)
            }
            .frame(width: proxy.size.width, height: proxy.size.height/1.5)
        }
    }
}
struct FirstUseView_Previews: PreviewProvider {
    static var previews: some View {
        FirstUseView()
    }
}
