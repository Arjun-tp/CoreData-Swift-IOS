//
//  Person+CoreDataProperties.swift
//  Test1
//
//  Created by eCOM-arjun.tp on 15/09/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var fee: Double
    @NSManaged public var termDate: String?

}

extension Person : Identifiable {

}
