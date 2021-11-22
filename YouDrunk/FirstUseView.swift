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
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    var body: some View {
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

struct FirstUseView_Previews: PreviewProvider {
    static var previews: some View {
        FirstUseView()
    }
}
