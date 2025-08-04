//
//  TodoTaskModel.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 31.07.2025.
//

struct TodoTaskModel {
    var name: String
    var description: String?
    var timestampCreated: Int
    var timestampModified: Int
    var isCompleted: Bool
    
    var formattedTimestampCreated: String {
        return Formatter.formatTimestamp(timestampCreated)
    }
    
    var formattedTimestampModified: String {
        return Formatter.formatTimestamp(timestampModified)
    }
}
