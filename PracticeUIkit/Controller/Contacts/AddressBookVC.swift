//
//  AddressBookVC.swift
//  PracticeUIkit
//
//  Created by ladmin on 16/05/2024.
//

import UIKit
import Contacts
import ContactsUI

class AddressBookVC: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var mytextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mytextField.add_UnderLine()
    }
    
    @IBAction func contactBookTapped(_ sender: Any) {
        let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        printSelectedContact(contact)
    }
    
    private func printSelectedContact(_ contact: CNContact) {
           // Print basic contact information
           print("Selected Contact:")
           print("Given Name: \(contact.givenName)")
           print("Family Name: \(contact.familyName)")
           
           // Print email addresses
           for emailAddress in contact.emailAddresses {
               print("Email: \(emailAddress.value)")
           }
           
           for phoneNumber in contact.phoneNumbers {
               print("Phone Number: \(phoneNumber.value.stringValue)")
           }
           
       }

}


//extension UITextField {
//    
//    func setUnderLine() {
//        let border = CALayer()
//        let width = CGFloat(5)
//        border.borderColor = UIColor.gray.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width + 21, height: self.frame.size.height)
//        border.borderWidth = width
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//    
//    
//    func add_UnderLine() {
//        let bottomLine = CALayer()
//        
//        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height - 3, width: self.bounds.width + 21, height: 5)
//        bottomLine.backgroundColor = UIColor.lightGray.cgColor
//        
//        self.borderStyle = UITextField.BorderStyle.none
//        self.layer.addSublayer(bottomLine)
//    }
//    
//}



@IBDesignable
class UnderlineView: UIView {

    @IBInspectable var underlineColor: UIColor = .gray {
        didSet {
            setUnderLine()
        }
    }

    @IBInspectable var underlineWidth: CGFloat = 2 {
        didSet {
            setUnderLine()
        }
    }
    
    @IBInspectable var upperlineWidth: CGFloat = 2 {
        didSet {
            setUpperLine()
        }
    }

    @IBInspectable var leftPadding: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }

    private var underlineLayer: CALayer?
    private var upperlineLayer: CALayer?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUnderLine()
        setUpperLine()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUnderLine()
        setUpperLine()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setUnderLine()
        setUpperLine()
    }

    private func setUnderLine() {
        // Remove existing underline layer if any
        underlineLayer?.removeFromSuperlayer()

        let border = CALayer()
        border.name = "underlineLayer"
        border.borderColor = underlineColor.cgColor
        border.borderWidth = underlineWidth
        border.frame = CGRect(x: leftPadding, y: self.frame.size.height - underlineWidth, width: (self.frame.size.width) - (leftPadding + rightPadding) , height: underlineWidth)

        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        underlineLayer = border
    }
    
    private func setUpperLine() {
        // Remove existing underline layer if any
        upperlineLayer?.removeFromSuperlayer()

        let border = CALayer()
        border.name = "underlineLayer"
        border.borderColor = underlineColor.cgColor
        border.borderWidth = underlineWidth
        border.frame = CGRect(x: leftPadding, y: 0, width: self.frame.size.width - (leftPadding + rightPadding), height: underlineWidth)

        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        upperlineLayer = border
    }
}



import UIKit

@IBDesignable
class UnderlineTextField: UITextField {

    @IBInspectable var underlineColor: UIColor = .gray {
        didSet {
            setUnderLine()
        }
    }

    @IBInspectable var underlineWidth: CGFloat = 2 {
        didSet {
            setUnderLine()
        }
    }

    @IBInspectable var leftPadding: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUnderLine()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUnderLine()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftPadding, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    func setUnderLine() {
        // Remove existing underline layers if any
        if let sublayers = self.layer.sublayers {
            for sublayer in sublayers {
                if sublayer.name == "underlineLayer" {
                    sublayer.removeFromSuperlayer()
                }
            }
        }

        let border = CALayer()
        border.name = "underlineLayer"
        border.borderColor = underlineColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - underlineWidth, width: self.frame.size.width + 21, height: underlineWidth)
        border.borderWidth = underlineWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
