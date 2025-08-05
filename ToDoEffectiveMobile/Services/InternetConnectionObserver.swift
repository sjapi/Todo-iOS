//
//  InternetConnectionObserver.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 01.08.2025.
//

import Network
import Foundation

final class InternetConnectionObserver {
    static let shared = InternetConnectionObserver()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "network.monitor.sjapi")

    private var _isReachable: Bool = true
    var isReachable: Bool {
        return _isReachable
    }

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self._isReachable = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
