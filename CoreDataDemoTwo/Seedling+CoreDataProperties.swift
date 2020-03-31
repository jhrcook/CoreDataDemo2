//
//  Seedling+CoreDataProperties.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 3/31/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//
//

import Foundation
import CoreData


extension Seedling {

    // @nonobjc public class func fetchRequest() -> NSFetchRequest<Seedling> {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Seedling> {
        return NSFetchRequest<Seedling>(entityName: "Seedling")
    }

    @NSManaged public var id: UUID
    @NSManaged public var dateSown: Date
    @NSManaged public var genus: String
    @NSManaged public var species: String
    @NSManaged public var numberOfSeeds: Int16

}
