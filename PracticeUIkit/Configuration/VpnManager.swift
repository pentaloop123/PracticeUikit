//
//  VpnManager.swift
//  PracticeUIkit
//
//  Created by New User on 08/04/2024.
//

import UIKit
import NetworkExtension


extension Notification.Name {
    static let vpnStatusChanged = Notification.Name("vpn-status-changed")
}

class VpnManager {
    
    static let shared = VpnManager()
    
    
    
    
    var evaluating = false
    var progress: Float = 0
    
    
    var manager: NETunnelProviderManager?
    var session: NETunnelProviderSession? {
        return manager?.connection as? NETunnelProviderSession
    }
    
     var _error: Error?
     var error: Error? {
        get {

            return _error
        }
        set {
            _error = newValue
        }
    }
    
    
    private init() {}
    

    func install(_ completed: Completed? = nil) {
        let conf = NETunnelProviderProtocol()
        conf.providerBundleIdentifier = "eventhorizon.rubiTV.devTeam.ext"
        conf.serverAddress = "Testing" /* "127.0.0.1"*/
        
        let manager = NETunnelProviderManager()
        manager.protocolConfiguration = conf
        manager.localizedDescription = "Practice UIkit"
        manager.onDemandRules = [NEOnDemandRuleConnect()]
        manager.isEnabled = true
        print("Manager: \(manager)")
        save(manager, completed)
    }
    
    private func save(_ manager: NETunnelProviderManager, _ completed: Completed? = nil) {
        manager.saveToPreferences { [weak self] error in
            if let error = error {
                print("Error saving VPN preferences: \(error.localizedDescription)")
            } else {
                print("VPN preferences saved successfully")
            }
            
            self?.reload(completed)
        }
    }
    
    func reload(_ completed: Completed? = nil) {
        NETunnelProviderManager.loadAllFromPreferences { [weak self] managers, error in
            self?.error = error
            self?.manager = managers?.first(where: { $0.isEnabled }) ?? managers?.first
            self?.postChange()
            completed?(self?.manager != nil)
        }
    }
    
    private func startTorVPN(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try manager?.connection.startVPNTunnel()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func stopTorVPN(completion: @escaping (Result<Void, Error>) -> Void) {
        manager?.connection.stopVPNTunnel()
    }
    
    private func postChange() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .vpnStatusChanged, object: self)
        }
    }


}

