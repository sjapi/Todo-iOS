//
//  InternetConnectionObserver.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 01.08.2025.
//

import Network
import Foundation

final class InternetConnectionObserver {
    // MARK: - Singleton
    static let shared = InternetConnectionObserver()
   
    // MARK: Properties
    private let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    private let lock = NSLock()
    
    var isReachable: Bool {
        lock.lock()
        defer {
            lock.unlock()
        }
        return status == .satisfied
    }
    
    // MARK: - Init
    private init() {
        startMonitoring()
    }
}

// MARK: - Private Methods
private extension InternetConnectionObserver {
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.status = path.status
        }
        
        let queue = DispatchQueue(label: "network.monitor.sjapi")
        monitor.start(queue: queue)
    }
}
