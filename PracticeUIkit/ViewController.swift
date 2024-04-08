//
//  ViewController.swift
//  PracticeUIkit
//
//  Created by New User on 03/04/2024.
//

//#import "HelloViewController.h";

import UIKit
import NetworkExtension

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func didTapVpnConnect(_ sender: Any) {
        VpnManager.shared.install()
    }
    
    
    @IBAction func didtapTorConnect(_ sender: Any) {
        
    }

    
}











//import Tor
//
//class TorManager {
//    static let shared = TorManager()
//    private var torController: TorController?
//
//    private init() {}
//
//    func startTor(completion: @escaping (Bool) -> Void) {
//        let torThread = TorThread()
//        torThread.start()
//
//        // Assuming you have a way to get the authentication cookie.
//        // This might involve reading from Tor's control auth cookie file.
//        let cookie = Data() // Use the correct cookie data for authentication.
//        let controlPort = UInt16(9051) // Default Tor control port.
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Wait for Tor to start.
//            self.torController = TorController(socketHost: "127.0.0.1", port: controlPort)
//            self.torController?.authenticate(with: cookie) { success, error in
//                if success {
//                    print("Tor authentication successful.")
//                    completion(true)
//                } else {
//                    print("Tor authentication failed: \(String(describing: error))")
//                    completion(false)
//                }
//            }
//        }
//    }
//}



