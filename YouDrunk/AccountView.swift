//
//  AccountView.swift
//  YouDrunk
//
//  Created by Simone Giordano on 16/11/21.
//

import SwiftUI

struct AccountView: View {
    
    @AppStorage("userAge") var userAge: Int = 20
    @AppStorage("userWeight") var userWeight: Int = 70
    @State var userGender: String = "Female"
    let possibleGender: [String] = ["Female", "Male"]
    

    
    init() {
        
    }
    var body: some View {
            VStack {
                Form {
                    VStack {
                        Section{
                            HStack {
                                Text("Age")
                                    .fontWeight(.regular)
                                Spacer()
                                Picker("Age", selection: $userAge) {
                                        ForEach((18...100), id: \.self) {
                                            Text("\($0)")
                                        }
                                    }
                                .pickerStyle(.menu)
                            }
                            HStack {
                                Text("Weight")
                                Spacer()
                                Picker("Weight", selection: $userWeight) {
                                        ForEach((20...120), id: \.self) {
                                            Text("\($0)")
                                                
                                            
                                        }
                                    }
                                .pickerStyle(.menu)
                            }
                            HStack {
                                Text ("Gender")
                                    .fontWeight(.regular)
                                Spacer()
                                Picker("Gender", selection: $userGender) {
                                    Text("Male").tag(0)
                                    Text("Female").tag(1)
                                        
                                    }
                                    
                                    
                                
                                .pickerStyle(.menu)
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
                
            }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
