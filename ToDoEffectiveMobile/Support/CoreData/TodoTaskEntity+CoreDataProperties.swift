//
//  TodoTaskEntity+CoreDataProperties.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 05.08.2025.
//
//

import Foundation
import CoreData

extension TodoTaskEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTaskEntity> {
        return NSFetchRequest<TodoTaskEntity>(entityName: "TodoTaskEntity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var timestampCreated: Int64
    @NSManaged public var timestampModified: Int64
    @NSManaged public var title: String?
}

extension TodoTaskEntity: Identifiable {

}
