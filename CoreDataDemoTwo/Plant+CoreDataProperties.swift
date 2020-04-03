//
//  Plant+CoreDataProperties.swift
//  CoreDataDemoTwo
//
//  Created by Joshua on 4/3/20.
//  Copyright © 2020 Joshua Cook. All rights reserved.
//
//

import Foundation
import CoreData


extension Plant {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var genus: String
    @NSManaged public var species: String
    @NSManaged public var uuid: UUID
    @NSManaged public var seeds: NSSet

}

// MARK: Generated accessors for seeds
extension Plant {

    @objc(addSeedsObject:)
    @NSManaged public func addToSeeds(_ value: Seed)

    @objc(removeSeedsObject:)
    @NSManaged public func removeFromSeeds(_ value: Seed)

    @objc(addSeeds:)
    @NSManaged public func addToSeeds(_ values: NSSet)

    @objc(removeSeeds:)
    @NSManaged public func removeFromSeeds(_ values: NSSet)

}
