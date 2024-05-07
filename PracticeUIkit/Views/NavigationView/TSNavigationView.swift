import UIKit

@IBDesignable
class RedNavigationBar: UINavigationBar {
    
    // MARK: - Initialization
    @IBInspectable var customHeight: CGFloat = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadNib()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = customHeight
        return newSize
    }
    
    // MARK: - Private Methods
    
    @discardableResult func loadNib() -> UIView? {
        guard let view = Bundle.main.loadNibNamed("NavigationView", owner: self, options: nil)?.first as? UIView else {
            return nil
        }
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.frame = bounds
        addSubview(view)
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
            
            // Find the UIBarBackground view
//            if stringFromClass.contains("UIBarBackground") {
//                // Set frame and background color
//                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
//                subview.backgroundColor = .green
//            }
        }
    }
}
