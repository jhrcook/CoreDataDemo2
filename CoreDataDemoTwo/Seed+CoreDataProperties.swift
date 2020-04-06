//
//  Seed+CoreDataProperties.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 4/3/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//
//

import Foundation
import CoreData


extension Seed {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Seed> {
        return NSFetchRequest<Seed>(entityName: "Seed")
    }

    @NSManaged public var seedCount: Int16
    @NSManaged public var dateSown: Date
    @NSManaged public var uuid: UUID
    @NSManaged public var plant: Plant

}
