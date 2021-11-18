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
    @AppStorage("userGender") var userGender: String = "Female"
    @AppStorage("userAddress") var userAddress: String = ""
    @AppStorage("userEmergencyNum") var userEmergencyNum: String = ""
    @AppStorage("userUnit") var userUnit: AlcoholUnit = AlcoholUnit.gl
    @AppStorage("userLanguages") var userLanguages: String = "English"
    let possibleLanguages: [String] = ["English", "Italian"]
    let possibleGender: [String] = ["Female", "Male"]
    let possibleUnits = [AlcoholUnit.gl, AlcoholUnit.bau]
    
    
    
    init() {
        
    }
    var body: some View {
        VStack {
            Form {
                
                Section (header: Text("Personal Information")){
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
                            ForEach(possibleGender, id: \.self) {
                                Text($0).tag($0)
                            }
                            
                        }
                        
                        
                        
                        .pickerStyle(.menu)
                    }
                }
                Section (header: Text("Panic Settings")){
                    
                    HStack {
                        
                        TextField("Home Address", text: $userAddress)
                    }
                    HStack {
                        
                        TextField("Emergency Number", text: $userEmergencyNum)
                    }
                }
                Section (header: Text("Other Settings")){
                    
                    
                        HStack {
                            Text("Unit of Measure")
                                .fontWeight(.regular)
                            Spacer()
                            Picker("Unit of Measure", selection: $userUnit) {
                                ForEach(possibleUnits, id: \.self) {
                                    Text("\(alcoholUnitDictionary[$0] ?? "")")
                                }
                            }
                            .pickerStyle(.menu)
                        
                        
                    }
                    HStack {
                Text("Languages")
                                           .fontWeight(.regular)
                                       Spacer()
                                       Picker("Languages", selection: $userLanguages) {
                                       ForEach(possibleLanguages, id: \.self) {
                                           Text($0).tag($0)
                                       }
                                   }
                                       .pickerStyle(.menu)
                               }
                                   HStack {

                                       
                                       Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                                           Text ("Notifications")
                                       }
                                   }
                                   
                                   
                
            }
            .padding(.vertical, 10)
            }
        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
