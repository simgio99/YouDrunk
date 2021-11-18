//
//  PanicView.swift
//  YouDrunk
//
//  Created by Danil Masnaviev on 18/11/21.
//

import SwiftUI

struct PanicView: View {
    var name = "John Doe"
    @AppStorage("userAddress") var userAddress: String = ""
    @AppStorage("userEmergencyNum") var userEmergencyNum: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text(name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    Link(userEmergencyNum, destination: URL(string: "tel:\(userEmergencyNum)")!)
                } header: {
                    Text("Number")
                }
                
                Section {
                    Text(userAddress)
                } header: {
                    Text("Address")
                }
            }
            .navigationTitle("Emergency")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    }
                    label : {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(primary_color)
                        }
                    }
            }
        }
    }
}

struct PanicView_Previews: PreviewProvider {
    static var previews: some View {
        PanicView()
    }
}
