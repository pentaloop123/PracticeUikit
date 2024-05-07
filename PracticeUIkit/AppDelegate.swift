//
//  AppDelegate.swift
//  PracticeUIkit
//
//  Created by New User on 03/04/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        UINavigationBar.appearance().backgroundColor = .red
        
//        UINavigationBar.appearance().barTintColor = .red
//        UINavigationBar.appearance().classForCoder = NavigationView.self
        
        
        
        // Create a resized version of the person.fill image
//        let originalImage = UIImage(systemName: "person.fill")
//        let resizedImage = resizeImage(originalImage, targetSize: CGSize(width: 100, height: 100))
        
        // Set the appearance of the back button
//        UINavigationBar.appearance().backIndicatorImage = resizedImage
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = resizedImage
        
        //        let backButtonImage = UIImage(systemName: "person.fill")
        //        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        //        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        
//        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for: .default)
        
        return true
    }
    
    func resizeImage(_ image: UIImage?, targetSize: CGSize) -> UIImage? {
            guard let image = image else { return nil }
            
            let size = image.size
            
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height

            let newSize: CGSize
            if widthRatio > heightRatio {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }

            let renderer = UIGraphicsImageRenderer(size: newSize)
            let newImage = renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: newSize))
            }

            return newImage
        }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

