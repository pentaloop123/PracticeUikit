//
//  DarkModeViewController.swift
//  PracticeUIkit
//
//  Created by New User on 08/05/2024.
//

import UIKit

class DarkModeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textfieldL: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldL.delegate = self
        
        handleAppearanceChange(traitCollection.userInterfaceStyle)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didtapLightDesing(_ sender: Any) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = .light  }
    }
    
    @IBAction func didtapdark(_ sender: Any) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = .dark  }
    }
    @IBAction func didtapSystem(_ sender: Any) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = .unspecified  }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Check if userInterfaceStyle has changed
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            handleAppearanceChange(traitCollection.userInterfaceStyle)
        }
    }
    
    func handleAppearanceChange(_ userInterfaceStyle: UIUserInterfaceStyle) {
        switch userInterfaceStyle {
            
        case .light:
            print("Light theme is enabled.")
            
        case .dark:
            print("Dark theme is enabled.")
            
        case .unspecified:
            print("User interface style is unspecified.")
            
        @unknown default:
            fatalError("Unknown user interface style.")
        }
    }
    
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //           // Calculate the new text after the replacement
    //           if let text = textField.text, let textRange = Range(range, in: text) {
    //               let newText = text.replacingCharacters(in: textRange, with: string)
    //               // newText now contains the new text in the text field
    //               print("New text: \(newText)")
    //           }
    //           return true
    //       }
    //
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let text = textField.text, let textRange = Range(range, in: text) {
//            let newText = text.replacingCharacters(in: textRange, with: string)
//            if canOpenURL(string: newText) {
//                print("Valid URL")
//                return true // Allow the replacement
//            } else {
//                print("Invalid URL")
//                return false // Prevent the replacement
//            }
//        }
        return true // Default behavior
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if canOpenURL(string: textField.text) {
            print("Valid URL")
            
        } else {
            print("Invalid URL")
            
        }
    }
    
    
    func canOpenURL(string: String?) -> Bool {
        let regEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
}
