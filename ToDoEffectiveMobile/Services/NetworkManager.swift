//
//  NetworkManager.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 01.08.2025.
//

import Foundation

protocol NetworkManager {
    func loadTodoTasks(completion: @escaping (Result<DummyJsonResponseModel, NetworkError>) -> Void)
}

final class URLSessionNetworkManager: NetworkManager {
    func loadTodoTasks(completion: @escaping (Result<DummyJsonResponseModel, NetworkError>) -> Void) {
        guard let url = URL(string: R.URLString.dummyJson) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.urlSessionError(error: error)))
                return
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            do {
                let response = try JSONDecoder().decode(DummyJsonResponseModel.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
}
