//
//  ChildSwiftUIVC.swift
//  PracticeUIkit
//
//  Created by New User on 26/04/2024.
//

import UIKit
import SwiftUI
//import AWSS3

class ChildSwiftUIVC: UIViewController {
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    static let S3BucketName: String = "invoicetestbucket"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        blurView.layer.cornerRadius = 20
            blurView.clipsToBounds = true
//        alert
        
        
        // Do any additional setup after loading the view.
        //        let hostingController = UIHostingController(rootView: ContentView())
        //        hostingController.view.frame = upperView.bounds
        //        addChild(hostingController)
        //        upperView.addSubview(hostingController.view)
        //        hostingController.didMove(toParent: self)
        
//        let hostingController = UIHostingController(rootView: ContentView())
//        hostingController.view.frame = upperView.frame
//        if let viewController = UIApplication.shared.windows.first?.rootViewController {
//            viewController.addChild(hostingController)
//            upperView.addSubview(hostingController.view)
//            hostingController.didMove(toParent: viewController)
//        }
        
    }
    
    @IBAction func didtapUploadImagetoBucket(_ sender: Any) {
        let image = UIImage(named: "alert")
//        uploadImageToS3(image: image!, fileName: "exampleImage.jpg")
    }
    
    @IBSegueAction func embededUiView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView())
    }
    
    

    
    
    
}
