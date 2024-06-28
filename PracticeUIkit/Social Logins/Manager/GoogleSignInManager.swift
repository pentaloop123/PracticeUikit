//
//  GoogleSignInManager.swift
//  PracticeUIkit
//
//  Created by ladmin on 27/06/2024.
//

import UIKit
import GoogleSignIn

class GoogleSignInManager: NSObject {
    static let shared = GoogleSignInManager()
    private var signInConfig: GIDConfiguration?
    
    private override init() {
        super.init()
        // Initialize the sign-in configuration
        signInConfig = GIDConfiguration(clientID: Constant.googleClientId)
    }

    func configure() {
        // No longer needed to set the delegate here
    }

    func signIn(presentingViewController: UIViewController, completion: @escaping (GIDGoogleUser?, Error?) -> Void) {
        guard let config = signInConfig else { return }
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: presentingViewController) { user, error in
//            completion(user, error)
//        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}


// MARK: - GIDSignInDelegate

//extension GoogleSignInManager: GIDSignInDelegate {
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print("Error signing in: \(error.localizedDescription)")
//        } else {
//            // Successfully signed in
//            print("User signed in: \(user.profile?.name ?? "No Name")")
//        }
//    }
//    
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print("Error disconnecting: \(error.localizedDescription)")
//        } else {
//            // Successfully disconnected
//        }
//    }
//}
