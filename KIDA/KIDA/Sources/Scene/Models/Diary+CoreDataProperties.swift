//
//  Diary+CoreDataProperties.swift
//  KIDA
//
//  Created by Ian on 2022/01/30.
//
//

import Foundation
import CoreData


extension Diary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diary> {
        return NSFetchRequest<Diary>(entityName: "Diary")
    }

    @NSManaged public var content: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var keyword: String?
    @NSManaged public var title: String?

}

extension Diary : Identifiable {

}
