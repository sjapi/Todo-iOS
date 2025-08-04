//
//  NetworkError.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 01.08.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case urlSessionError(error: Error)
    case decodeError
    case noData
    case noConnection
}
