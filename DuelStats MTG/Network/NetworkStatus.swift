//
//  NetworkStatus.swift
//  Beyond Earth
//
//  Created by Alvaro Santos Orellana on 6/9/24.
//

import SwiftUI
import Network

@Observable
final class NetworkStatus {
    enum Status {
        case offline, online, unknown
    }

    var status: Status = .unknown
    
    let monitor = NWPathMonitor()
    var queue = DispatchQueue(label: "MonitorNetwork")
    
    init() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [self] path in
            DispatchQueue.main.async {
                self.status = path.status == .satisfied ? .online : .offline
            }
        }
        status = monitor.currentPath.status == .satisfied ? .online : .offline
    }
}
