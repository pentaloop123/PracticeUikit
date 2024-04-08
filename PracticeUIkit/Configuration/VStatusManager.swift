//
//  VStatusManager.swift
//  PracticeUIkit
//
//  Created by New User on 08/04/2024.
//

import NetworkExtension


extension VpnManager{
    
    typealias Completed = (_ success: Bool) -> Void
    enum Status: CustomStringConvertible {

        case notInstalled
        case disabled
        case invalid
        case disconnected
        case evaluating
        case connecting
        case connected
        case reasserting
        case disconnecting
        case unknown


        var description: String {
            switch self {
            case .notInstalled:
                return NSLocalizedString("Not Installed", comment: "")

            case .disabled:
                return NSLocalizedString("Disabled", comment: "")

            case .invalid:
                return NSLocalizedString("Invalid", comment: "")

            case .disconnected:
                return NSLocalizedString("Ready to Connect", comment: "")

            case .evaluating:
                return NSLocalizedString("Evaluating", comment: "")

            case .connecting:
                return NSLocalizedString("Connecting", comment: "")

            case .connected:
                return NSLocalizedString("Connected", comment: "")

            case .reasserting:
                return NSLocalizedString("Reasserting", comment: "")

            case .disconnecting:
                return NSLocalizedString("Disconnecting", comment: "")

            case .unknown:
                return NSLocalizedString("Unknown", comment: "")
            }
        }
    }
    
    
    var status: Status {
        guard let manager = manager else {
            return .notInstalled
        }
        
        guard manager.isEnabled else {
            return .disabled
        }
        
        guard !evaluating else {
            return .evaluating
        }
        
        switch session?.status ?? .invalid {
        case .invalid:
            return .invalid
        case .disconnected:
            return .disconnected
        case .connecting:
            return .connecting
        case .connected:
            if progress > 0 && progress < 1 {
                return .connecting
            }
            return .connected
        case .reasserting:
            return .reasserting
        case .disconnecting:
            return .disconnecting
        @unknown default:
            return .unknown
        }
    }
    
    
    var statusDescription: String {
        switch status {
        case .notInstalled:
            return "VPN is not installed"
        case .disabled:
            return "VPN is disabled"
        case .invalid:
            return "VPN is in an invalid state"
        case .disconnected:
            return "VPN is disconnected"
        case .evaluating:
            return "VPN is being evaluated"
        case .connecting:
            return "VPN is connecting"
        case .connected:
            return "VPN is connected"
        case .reasserting:
            return "VPN is reasserting the connection"
        case .disconnecting:
            return "VPN is disconnecting"
        case .unknown:
            return "VPN is in an unknown state"
        }
    }

    
}
