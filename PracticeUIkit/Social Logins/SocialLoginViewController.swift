//
//  SocialLoginViewController.swift
//  PracticeUIkit
//
//  Created by ladmin on 27/06/2024.
//

import UIKit
import GoogleSignIn


class SocialLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didtapBtn(_ sender: UIButton) {
        switch sender.tag{
        case 0:
            print("Email")
            GoogleSignInManager.shared.signOut()
            print("User signed out")
            
        case 1:
            print("Apple")
            
        case 2:
            print("Google")
            GoogleSignInManager.shared.signIn(presentingViewController: self) { user, error in
                if let error = error {
                    print("Error signing in: \(error.localizedDescription)")
                } else if let user = user {
                    print("User signed in: \(user.profile?.name ?? "No Name")")
                }
            }
            
        case 3:
            print("FaceBook")
            
        default:
            break
        }
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
                if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                    debugPrint("The user has not signed in before or they have since signed out.")
                } else {
                    debugPrint("\(error.localizedDescription)")
                }
                return
            }
        debugPrint(user.profile?.email ?? "")
        debugPrint(user.profile?.name ?? "")
            debugPrint(user.profile.givenName ?? "")
            debugPrint(user.profile.familyName ?? "")
            showAlert(title: "SUCCESS", message: "Thanks for signing in with google")
              
        }
    
    
}
