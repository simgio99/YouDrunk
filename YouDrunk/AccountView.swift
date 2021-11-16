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
    
    init() {
        
    }
    var body: some View {
        NavigationView {
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
                        }
                    }
                }
                    
                
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
