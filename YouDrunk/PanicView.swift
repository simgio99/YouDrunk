//
//  PanicView.swift
//  YouDrunk
//
//  Created by Danil Masnaviev on 18/11/21.
//

import SwiftUI

struct PanicView: View {
    var name = "John Doe"
    var emergencyNumber = "+(39)351-521-1350"
    
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
                    Link(emergencyNumber, destination: URL(string: "tel:\(emergencyNumber)")!)
                } header: {
                    Text("Number")
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
