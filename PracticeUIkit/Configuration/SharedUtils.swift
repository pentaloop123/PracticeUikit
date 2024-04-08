//
//  SharedUtils.swift
//  PracticeUIkit
//
//  Created by New User on 08/04/2024.
//

import Foundation
import NetworkExtension


class SharedUtils: NSObject{
    
    static func control(onlyTo status: VpnManager.Status? = nil) {

        // Enable, if disabled.
//        if VpnManager.shared.status == .disabled {
//            return VpnManager.shared.enable { success in
//                if success && VpnManager.shared.status != .disabled {
//                    control(onlyTo: status)
//                }
//            }
//        }

        if status == .connected && ![VpnManager.Status.disconnected, .disconnecting].contains(VpnManager.shared.status) {
            return
        }

        if status == .disconnected && ![VpnManager.Status.connected, .connecting, .evaluating, .reasserting].contains(VpnManager.shared.status) {
            return
        }

        switch VpnManager.shared.status {
        case .notInstalled:
            VpnManager.shared.install()

//        case .evaluating, .connecting, .connected, .reasserting:
//            VpnManager.shared.disconnect(explicit: true)
//
//        case .disconnected, .disconnecting:
//            VpnManager.shared.connect()

        default:
            break
        }
    }
}
