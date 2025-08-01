//
//  DummyJsonResponseModel.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 01.08.2025.
//

import Foundation

struct DummyJsonResponseModel: Decodable {
    let todos: [Todo]
    let total: Int
    let skip: Int
    let limit: Int
    
    struct Todo: Decodable {
        let id: Int
        let todo: String
        let completed: Bool
        let userID: Int
    }
}
