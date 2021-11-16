//
//  YouDrunkApp.swift
//  YouDrunk
//
//  Created by Simone Giordano on 09/11/21.
//

import SwiftUI

@main
struct YouDrunkApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
            
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onChange(of: scenePhase) { _ in
                    persistenceController.save()
                }
        }
    }
}
