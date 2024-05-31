//
//  ScrollTestVC.swift
//  PracticeUIkit
//
//  Created by ladmin on 21/05/2024.
//

import UIKit

class ScrollTestVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isHide = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didtapDownBtn(_ sender: Any) {
        isHide.toggle()
        
        // Update the height constraint and animate the change
        containerView.isHidden = isHide
        containerViewHeightConstraint.constant = isHide ? 0 : 200 // Set the original height of the containerView
        
        // Animate the layout change
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}
