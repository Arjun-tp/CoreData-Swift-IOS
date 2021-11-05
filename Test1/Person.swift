//
//  Person.swift
//  Test1
//
//  Created by eCOM-arjun.tp on 15/09/21.
//

import CoreData

@objc(Person)
class Person: NSManagedObject{
    @NSManaged var name: String
    @NSManaged var age: Int32
    @NSManaged var fee: Double
    @NSManaged var termDate: String

}
