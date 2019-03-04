//
//  ReachabilityTracker.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 04/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation
import Connectivity

class ReachabilityTracker {

    static private var connectivity = Connectivity()

    static func start() {
        connectivity.framework = .network
        connectivity.whenConnected = connectivityChanged
        connectivity.whenDisconnected = connectivityChanged
        connectivity.startNotifier(queue: DispatchQueue(label: "Reachability", qos: .background))
    }

    static let connectivityChanged: (Connectivity) -> Void = { connectivity in
        DispatchQueue.main.async {
            updateConnectionStatus(connectivity.status)
        }
    }

    static func updateConnectionStatus(_ status: ConnectivityStatus) {
        switch status {
        case .notConnected, .connectedViaCellularWithoutInternet, .connectedViaWiFiWithoutInternet:
            BannerManager.displayOfflineBanner()
        default:
            BannerManager.dismissOfflineBanner()
        }
    }
}
