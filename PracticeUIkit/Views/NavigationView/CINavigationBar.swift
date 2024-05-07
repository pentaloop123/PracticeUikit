
import UIKit

@IBDesignable
class CINavigationBar: UINavigationBar {

    // Set NavigationBar's height
    @IBInspectable var customHeight: CGFloat = 66

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        UINavigationBar.appearance().backgroundColor = .red
        
        // Iterate through subviews of the navigation bar
//        for subview in self.subviews {
//            var stringFromClass = NSStringFromClass(subview.classForCoder)
//
//            // Find the UIBarBackground view
//            if stringFromClass.contains("UIBarBackground") {
//                // Set frame and background color
//                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
//                subview.backgroundColor = .red
//            }
//
//            // Find the UINavigationBarContentView
////            if stringFromClass.contains("UINavigationBarContentView") {
////                // Set frame and background color
////                let centerY = (customHeight - subview.frame.height) / 2.0
////                subview.frame = CGRect(x: 0, y: centerY, width: self.frame.width, height: subview.frame.height)
////                subview.backgroundColor = .green
////
////                // Add a red view inside UINavigationBarContentView
////                let redView = UIView(frame: CGRect(x: 0, y: 0, width: subview.frame.width, height: 20))
////                redView.backgroundColor = .red
////                subview.addSubview(redView)
////            }
//        }
    }
}

