//
//  Reachability.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation
import Network

protocol Reachable {
    var isConnected: Bool {get}
    func startNetworkReachabilityObserver()
}

class Reachability: Reachable {

    static let shared = Reachability()
    private let monitor = NWPathMonitor()
    
    private init() {

    }

    var isConnected: Bool {
       return  monitor.currentPath.status == .satisfied
    }

    func startNetworkReachabilityObserver() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                NotificationCenter.default.post(name: Notifications.Reachability.connected.name, object: nil)
            } else if path.status == .unsatisfied {
                NotificationCenter.default.post(name: Notifications.Reachability.notConnected.name, object: nil)
            }
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}
