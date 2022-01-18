//
//  Diary+CoreDataProperties.swift
//  KIDA
//
//  Created by Ian on 2022/01/18.
//
//

import Foundation
import CoreData


extension Diary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diary> {
        return NSFetchRequest<Diary>(entityName: "Diary")
    }

    @NSManaged public var title: String?
    @NSManaged public var keyword: String?
    @NSManaged public var content: String?
    @NSManaged public var createdAt: Date?

}

extension Diary : Identifiable {

}
