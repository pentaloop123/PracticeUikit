//
//  SwitchesViewController.swift
//  PracticeUIkit
//
//  Created by ladmin on 20/05/2024.
//

import UIKit

class SwitchesViewController: UIViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var selectedSegmentLabel: UILabel!
    
    var itemCount: Int = 0 {
        didSet {
            selectedSegmentLabel.text = "Item count changed to \(itemCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
        selectedSegmentLabel.text = "First"
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
    }
    @IBAction func didtapCountBtn(_ sender: Any) {
        itemCount += 1
        
    }
    
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegmentLabel.text = "First"
        case 1:
            selectedSegmentLabel.text = "Second"
        default:
            break
        }
    }
    
}
