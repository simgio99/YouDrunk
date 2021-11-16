//
//  CoreDrink+CoreDataProperties.swift
//  YouDrunk
//
//  Created by Simone Giordano on 16/11/21.
//
//

import Foundation
import CoreData


extension CoreDrink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDrink> {
        return NSFetchRequest<CoreDrink>(entityName: "CoreDrink")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: Int16
    @NSManaged public var alcohol_percentage: Float

}

extension CoreDrink : Identifiable {

}
