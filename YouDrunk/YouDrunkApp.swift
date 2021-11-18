//
//  YouDrunkApp.swift
//  YouDrunk
//
//  Created by Simone Giordano on 09/11/21.
//

import SwiftUI

@main
struct YouDrunkApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    let CDInstance = CDManager.getInstance()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CDInstance.dataContainer.viewContext)
                .onChange(of: scenePhase) { _ in
                    CDInstance.save()
                }
                
        }
    }
}
