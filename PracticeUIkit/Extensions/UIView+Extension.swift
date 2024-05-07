

import UIKit


@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor:UIColor? {
          set {
              layer.borderColor = newValue!.cgColor
          }
          get {
              if let color = layer.borderColor {
                  return UIColor(cgColor:color)
              }
              else {
                  return nil
              }
          }
      }
    
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
}
