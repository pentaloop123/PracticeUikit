//
//  BaseViewController.swift
//  PracticeUIkit
//
//  Created by New User on 08/04/2024.
//

class BaseViewController: UIViewController {
    
//    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a scroll view and add it as a subview
//        scrollView = UIScrollView(frame: view.bounds)
//        view.addSubview(scrollView)
//        
//        // Move the existing subviews to the scroll view
//        for subview in view.subviews {
//            if subview != scrollView {
//                subview.removeFromSuperview()
//                scrollView.addSubview(subview)
//            }
//        }
        
        // Enable autoresizing mask for the scroll view
//        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        // Check if the device height is less than 800 points
//        if view.bounds.size.height < 800 {
//            let contentSize = calculateContentSize()
//            scrollView.contentSize = contentSize
//            
//            // Scroll to the top of the view
//            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
//        } else {
//            // Reset the content size for larger devices
//            scrollView.contentSize = view.bounds.size
//        }
//    }
//    
//    func calculateContentSize() -> CGSize {
//        // Calculate the total height of the subviews
//        var totalHeight: CGFloat = 0
//        
//        for subview in scrollView.subviews {
//            totalHeight += subview.frame.size.height
//        }
//        
//        // Return the content size based on the total height of the subviews
//        return CGSize(width: view.bounds.size.width, height: totalHeight)
//    }
}
