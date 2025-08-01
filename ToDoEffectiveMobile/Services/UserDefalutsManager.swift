//
//  UserDefalutsManager.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 01.08.2025.
//

import Foundation

final class UserDefaultsManager {
    enum Keys: String {
        case isDataDownloaded
    }
    static let shared = UserDefaultsManager()
   
    private init() {}
    
    var areTodosDownloaded: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.isDataDownloaded.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isDataDownloaded.rawValue)
        }
    }
}
