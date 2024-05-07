//
//  SystemScanViewController.swift
//  PracticeUIkit
//
//  Created by New User on 18/04/2024.
//

import UIKit

class SystemScanViewController: UIViewController {
    
    
    
    @IBOutlet weak var bulletTextField: UITextView!
    @IBOutlet weak var visualinternalView: UIView!
    @IBOutlet weak var visualView: UIVisualEffectView!
    @IBOutlet weak var bulletlable: UILabel!
    
    var ssText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualinternalView.layer.cornerRadius = 20
        
        
        let originalString = "A weekly blog about Swift"
        let attributedString = makeBoldText(string: originalString)
        
        
        
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let text = "1. Open ‘Settings’ \n2. Select 'Face ID/Touch ID & Passcode.'\n3. Tap 'Turn Passcode On.'\n4. Create a 6-digit passcode\n5. Confirm your passcode by entering it once more."
        
        let butedString = makeBoldText(string: text)
        bulletTextField.attributedText = butedString
        bulletlable.attributedText = butedString
        let enclosedWords = findWordsEnclosedInSingleQuotes(text)
        print(enclosedWords)
        
        let mercedes = Vehicle(type: .Car)
        mercedes.startEngine(minutes: 60)
        print(mercedes.returnMiles())
        
    }
    
    
    func makeBoldText(string: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        
        // Define the ranges for the parts to make bold
        let boldRanges: [(String, NSRange)] = [
            ("Settings", (string as NSString).range(of: "Settings")),
            ("Face ID/Touch ID & Passcode.", (string as NSString).range(of: "Face ID/Touch ID & Passcode.")),
            ("Turn Passcode On.", (string as NSString).range(of: "Turn Passcode On.")),
        ]
        
        // Apply semibold attribute to the specified ranges
        for (boldString, range) in boldRanges {
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 12), range: range)
        }
        
        return attributedString
    }
    
    func findWordsEnclosedInSingleQuotes(_ text: String) -> [String] {
        let pattern = "'([^']+)'"
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        
        var words: [String] = []
        for match in matches {
            if let range = Range(match.range(at: 1), in: text) {
                let word = String(text[range])
                words.append(word)
            }
        }
        
        return words
    }
    
    func addBulletPointsToString(text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        let lines = text.components(separatedBy: "\n")
        var index = 1
        
        for line in lines {
            let numberedString = "\(index). \(line)\n"
            let attributedLine = NSAttributedString(string: numberedString, attributes: [
                NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 17)!,
                NSAttributedString.Key.paragraphStyle: createParagraphStyle(lineHeight: 30)
            ])
            attributedString.append(attributedLine)
            index += 1
        }
        
        return attributedString
    }

    func createParagraphStyle(lineHeight: CGFloat) -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - UIFont(name: "Chalkduster", size: 15)!.lineHeight
        return paragraphStyle
    }


    
    
    @IBAction func didtapSwitch(_ sender: UISwitch) {
        if sender.isOn {
            // Switch is ON
            ssText = "Open ‘Settings’\nSelect 'Face ID/Touch ID & Passcode.'\nTap 'Turn Passcode On.'\nCreate a 6-digit passcode\nConfirm your passcode by entering it once more."
            let attributedString = addBulletPointsToString(text: ssText)
            
            
            bulletTextField.text = "Open ‘Settings’\nSelect 'Face ID/Touch ID & Passcode.'\nTap 'Turn Passcode On.'\nCreate a 6-digit passcode\nConfirm your passcode by entering it once more."
            visualView.isHidden = true
            print("Switch is ON")
        } else {
            // Switch is OFF
            ssText = "Open ‘Settings’\nSelect 'Face ID/Touch ID & Passcode.\nTap 'Turn Passcode On.\nCreate a 6-digit passcode\n Confirm your passcode by entering it once more"
            let attributedString = addBulletPointsToString(text: ssText)
            bulletTextField.attributedText = attributedString
            visualView.isHidden = false
            print("Switch is OFF")
        }
    }
    
    func additionOfNumbers(num1: Int, num2: Int) -> Int{
        return num1 + num2 + 10
    }
    
}

