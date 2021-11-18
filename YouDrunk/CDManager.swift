//
//  CDManager.swift
//  YouDrunk
//
//  Created by Simone Giordano on 17/11/21.
//

import Foundation
import CoreData



class CDManager {
    
    static let sharedInstance = CDManager() // Using a singleton instance across the program
    // Container for storing the actual data
    let dataContainer: NSPersistentContainer
    
    init(inMemory: Bool = false, dataModelName: String = "") {
        
        self.dataContainer = NSPersistentContainer(name: dataModelName)
        if inMemory {
            dataContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "dev/null")
        }
        dataContainer.loadPersistentStores {
            description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)") }
            
        }
    }
    func save() {
        let context = dataContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: Could not save context of persistent data")
            }
        }
    }
    
    func wipe(_ entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try CDManager.getInstance().dataContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func getInstance() -> CDManager {
        return CDManager.sharedInstance
    }
    
}
