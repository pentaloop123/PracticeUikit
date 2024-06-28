
import UIKit

class SegmentViewController: UIViewController, YSSegmentedControlDelegate {

    
    var segmentedControl: YSSegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles = ["First", "Second", "Third", "Fourth", "Fifth"]
        segmentedControl = YSSegmentedControl(frame: containerView.bounds, titles: titles)
        segmentedControl.delegate = self
        
        // Customize the appearance if needed
        let appearance = YSSegmentedControlAppearance(
            backgroundColor: .white,
            selectedBackgroundColor: .blue,
            unselectedTextAttributes: [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor.rawValue: UIColor.black],
            selectedTextAttributes: [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white],
            bottomLineColor: .clear,
            selectorColor: .blue,
            bottomLineHeight: 0,
            selectorHeight: 3,
            itemTopPadding: 10,
            selectedCornerRadius: 5,
            selectedBorderWidth: 1,
            selectedBorderColor: .blue,
            selectorOffsetFromLabel: nil,
            selectorSpansFullItemWidth: true,
            labelsOnEndsFloatToEdges: false
        )
        
        segmentedControl.appearance = appearance
        containerView.addSubview(segmentedControl)
        
    }
    
    
    
    @IBAction func didtapBtn(_ sender: Any) {
        
    }
    
    
    
    
    func segmentedControl(_ segmentedControl: YSSegmentedControl, willPressItemAt index: Int) {
        print("Will press item at index: \(index)")
    }
    
    func segmentedControl(_ segmentedControl: YSSegmentedControl, didPressItemAt index: Int) {
        print("Did press item at index: \(index)")
    }
    
}
