

import UIKit

// MARK: - Appearance

public struct YSSegmentedControlAppearance {
    public var backgroundColor: UIColor
    public var selectedBackgroundColor: UIColor
    
    public var unselectedTextAttributes: [String : Any]
    public var selectedTextAttributes: [String : Any]
    
    public var bottomLineColor: UIColor
    public var selectorColor: UIColor
    public var bottomLineHeight: CGFloat
    public var selectorHeight: CGFloat
    public var itemTopPadding: CGFloat
    public var selectedCornerRadius: CGFloat
    public var selectedBorderWidth: CGFloat
    public var selectedBorderColor: UIColor
    /**
     The distance between the top of the selector and the bottom
     of the label.
     If this is nil, then the selector will be anchored on the bottom
     of the segmented control;
     otherwise the selector will be this distance from the bottom of the label.
     */
    public var selectorOffsetFromLabel: CGFloat?
    
    /**
     Whether or not the selector spans the full width of the
     YSSegmentedControlItem.
     If set to true, the selector will span the entire width of the item;
     if set to false, the selector will span the entire width of the label.
     */
    public var selectorSpansFullItemWidth: Bool
    
    /**
     Whether or not the labels on the ends (first and last) float to the edges
     or are centered within the item.
     If set to `true`, then the labels float to the edges;
     if set to `false`, then the labels are centered.
     
     Default value is `false`.
     */
    public var labelsOnEndsFloatToEdges: Bool
}

// MARK: - Control Item

typealias YSSegmentedControlItemAction = (_ item: YSSegmentedControlItem) -> Void

@objc class YSSegmentedControlItem: UIControl {
    
    // MARK: Properties
    
    private var willPress: YSSegmentedControlItemAction?
    private var didPress: YSSegmentedControlItemAction?
    
    var label: UILabel!
    let labelAlignment: NSTextAlignment
    
    // MARK: Init
    
    init(frame: CGRect,
         text: String,
         appearance: YSSegmentedControlAppearance,
         willPress: YSSegmentedControlItemAction?,
         didPress: YSSegmentedControlItemAction?,
         labelAlignment: NSTextAlignment) {
        self.willPress = willPress
        self.didPress = didPress
        self.labelAlignment = labelAlignment
        
        super.init(frame: frame)
        
        
        commonInit()
        
        
        /* punit made change here to support swift 4 */
        let attributes: [String : Any]? = appearance.unselectedTextAttributes
        
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: attributedString.string.utf16.count)
        
        if let attributes = attributes {
            let convertedAttributes = Dictionary(uniqueKeysWithValues:
                attributes.lazy.map { (NSAttributedString.Key($0.key), $0.value) }
            )
            attributedString.addAttributes(convertedAttributes, range: range)
        }
        
        label.attributedText = attributedString
        
        //label.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font.rawValue: unselectedFont, NSAttributedStringKey.foregroundColor.rawValue: UIColorFromRGB(rgbValue: 0x6f6f6f)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.labelAlignment = .center
        super.init (coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.backgroundColor = UIColor.blue
        addSubview(label)
        
        let attribute: NSLayoutConstraint.Attribute
        
        switch labelAlignment {
        case .left:
            attribute = .leading
        case .right:
            attribute = .trailing
        default:
            attribute = .centerX
        }
        
        addConstraint(NSLayoutConstraint(item: label, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: 1.0, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        let views: [String: Any] = ["label": label]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=0)-[label]-(>=0)-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=0)-[label]-(>=0)-|", options: [], metrics: nil, views: views))
    }
    
    // MARK: UI Helpers
    
    func updateLabelAttributes(_ attributes: [String : Any]) {
        guard let labelText = label.text else {
            return
        }
        
        /* punit made change here to support swift 4 */
        let attributes: [String : Any]? = attributes
        
        let attributedString = NSMutableAttributedString(string: labelText)
        let range = NSRange(location: 0, length: attributedString.string.utf16.count)
        
        if let attributes = attributes {
            let convertedAttributes = Dictionary(uniqueKeysWithValues:
                attributes.lazy.map { (NSAttributedString.Key($0.key), $0.value) }
            )
            attributedString.addAttributes(convertedAttributes, range: range)
        }
        
        label.attributedText = attributedString
        
        // punit label.attributedText = NSAttributedString(string: labelText, attributes: attributes as! [NSAttributedStringKey: Any])
    }
    
    // MARK: Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        willPress?(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        didPress?(self)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        didPress?(self)
    }
}


// MARK: - Control

public protocol YSSegmentedControlDelegate: class {
    func segmentedControl(_ segmentedControl: YSSegmentedControl, willPressItemAt index: Int)
    func segmentedControl(_ segmentedControl: YSSegmentedControl, didPressItemAt index: Int)
}

public typealias YSSegmentedControlAction = (_ segmentedControl: YSSegmentedControl, _ index: Int) -> Void

@objc public class YSSegmentedControl: UIView {
    
    // MARK: Properties
    
    weak var delegate: YSSegmentedControlDelegate?
    public var action: YSSegmentedControlAction?
    
    @objc public var selectedIndex = 0
    
    public var appearance: YSSegmentedControlAppearance! {
        didSet {
            self.draw()
        }
    }
    
    public var titles: [String]! {
        didSet {
            if appearance == nil {
                defaultAppearance()
            }
            else {
                self.draw()
            }
        }
    }
    
    var items = [YSSegmentedControlItem]()
    var selector = UIView()
    var bottomLine = CALayer()
    
    fileprivate var selectorLeadingConstraint: NSLayoutConstraint?
    fileprivate var selectorWidthConstraint: NSLayoutConstraint?
    fileprivate var selectorBottomConstraint: NSLayoutConstraint?
    
    
    
    
    // MARK: Init
    @objc public init (frame: CGRect, titles: [String], action: YSSegmentedControlAction? = nil) {
        super.init (frame: frame)
        self.action = action
        self.titles = titles
        defaultAppearance()
    }
    
    required public init? (coder aDecoder: NSCoder) {
        super.init (coder: aDecoder)
    }
    
    // MARK: Draw
    
    private func reset() {
        for sub in subviews {
            let v = sub
            v.removeFromSuperview()
        }
        
        items.removeAll()
    }
    
    private func draw() {
        reset()
        backgroundColor = appearance.backgroundColor
        for (index, title) in titles.enumerated() {
            let labelAlignment: NSTextAlignment
            
            if appearance.labelsOnEndsFloatToEdges {
                switch index {
                case 0:
                    labelAlignment = .left
                case titles.count - 1:
                    labelAlignment = .right
                default:
                    labelAlignment = .center
                }
            }
            else {
                labelAlignment = .center
            }
            
            let item = YSSegmentedControlItem(
                frame: .zero,
                text: title,
                appearance: appearance,
                willPress: { [weak self] segmentedControlItem in
                    guard let weakSelf = self else {
                        return
                    }
                    
                    let index = weakSelf.items.index(of: segmentedControlItem)!
                    weakSelf.delegate?.segmentedControl(weakSelf, willPressItemAt: index)
                },
                didPress: { [weak self] segmentedControlItem in
                    guard let weakSelf = self else {
                        return
                    }
                    
                    let index = weakSelf.items.index(of: segmentedControlItem)!
                    weakSelf.selectItem(at: index, withAnimation: true)
                    weakSelf.action?(weakSelf, index)
                    weakSelf.delegate?.segmentedControl(weakSelf, didPressItemAt: index)
                },
                labelAlignment: labelAlignment)
            addSubview(item)
            items.append(item)
        }
        
        // bottom line
//        bottomLine.backgroundColor = appearance.bottomLineColor.cgColor
//        layer.addSublayer(bottomLine)
        
        // selector
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.backgroundColor = appearance.selectorColor
        addSubview(selector)
        
        addConstraint(NSLayoutConstraint(item: selector, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: appearance.selectorHeight))
        
        selectItem(at: selectedIndex, withAnimation: true)
        
        setNeedsLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = frame.size.width / CGFloat(titles.count)
//        var currentX: CGFloat = 0
        let assignedWidth = width - 15;
        var currentX: CGFloat = (width / 2) - (assignedWidth / 2)
        
        for item in items {
            item.frame = CGRect(
                x: currentX,
                y: appearance.itemTopPadding,
                width: assignedWidth,
                height: frame.size.height - appearance.itemTopPadding)
            currentX += width
            item.layer.cornerRadius = 14.0;
            item.clipsToBounds = true
        }
        
//        bottomLine.frame = CGRect(
//            x: 0,
//            y: frame.size.height - appearance.bottomLineHeight,
//            width: frame.size.width,
//            height: appearance.bottomLineHeight)
    }
    
    private func defaultAppearance() {
        
//        let unselectedFont: UIFont = UIFont.systemFont(ofSize: 12)
//        let selectedFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
        let unselectedFont: UIFont = UIFont.systemFont(ofSize: 15)
                let selectedFont: UIFont = UIFont.boldSystemFont(ofSize: 15)
//        var unselectedFont: UIFont = UIFont (name: "System-Regular", size: 12)!
//        var selectedFont: UIFont = UIFont (name: "CircularStd-Bold", size: 12)!
        
        /*if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.bounds.size.width{
            case 320:
                unselectedFont = UIFont (name: "CircularStd-Book", size: 11)!
                selectedFont = UIFont (name: "CircularStd-Bold", size: 11)!
            case 375:
                unselectedFont = UIFont (name: "CircularStd-Book", size: 12)!
                selectedFont = UIFont (name: "CircularStd-Bold", size: 12)!
            case 414:
                unselectedFont = UIFont (name: "CircularStd-Book", size: 13)!
                selectedFont = UIFont (name: "CircularStd-Bold", size: 13)!
            default:
                print("other models")
            }
        }*/
        //defaultAppearance
        appearance = YSSegmentedControlAppearance(
            backgroundColor: .clear,
            selectedBackgroundColor: UIColorFromRGB(rgbValue: 0x5490DF, alpha: 0.11),
            unselectedTextAttributes: [NSAttributedString.Key.font.rawValue: unselectedFont, NSAttributedString.Key.foregroundColor.rawValue: UIColorFromRGB(rgbValue: 0x4F4F4F, alpha: 1)],
            selectedTextAttributes: [NSAttributedString.Key.font.rawValue: selectedFont, NSAttributedString.Key.foregroundColor.rawValue: UIColorFromRGB(rgbValue: 0x0377F6, alpha: 1)],
//            bottomLineColor: UIColorFromRGB(rgbValue: 0x0081f9),
            bottomLineColor: .clear,
            selectorColor: UIColorFromRGB(rgbValue: 0x5490DF, alpha: 0.11),
            bottomLineHeight: 0,
            selectorHeight: 0,
            itemTopPadding: 10,
            selectedCornerRadius: 14,
            selectedBorderWidth: 1,
            selectedBorderColor: UIColorFromRGB(rgbValue: 0x80B7FF, alpha: 0.27),
            selectorOffsetFromLabel: nil,
            selectorSpansFullItemWidth: true,
            labelsOnEndsFloatToEdges: false)
    }
    
    func UIColorFromRGB(rgbValue: UInt,alpha: CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    // MARK: Select
    
    @objc public func selectItem(at index: Int, withAnimation animation: Bool) {
        self.selectedIndex = index
        moveSelector(at: index, withAnimation: animation)
        for item in items {
            if item == items[index] {
                item.updateLabelAttributes(appearance.selectedTextAttributes)
                item.backgroundColor = appearance.selectedBackgroundColor
                item.layer.borderWidth = appearance.selectedBorderWidth
                item.layer.borderColor = appearance.selectedBorderColor.cgColor
                item.layer.cornerRadius = appearance.selectedCornerRadius
            } else {
                item.updateLabelAttributes(appearance.unselectedTextAttributes)
                item.backgroundColor = appearance.backgroundColor
                item.layer.borderColor = UIColor.clear.cgColor
                item.layer.borderWidth = 0
            }
        }
    }
    
    private func moveSelector(at index: Int, withAnimation animation: Bool) {
        guard items.count > selectedIndex else {
            return
        }
        
        layoutIfNeeded()
        
        if let selectorWidthConstraint = selectorWidthConstraint {
            removeConstraint(selectorWidthConstraint)
        }
        if let selectorLeadingConstraint = selectorLeadingConstraint {
            removeConstraint(selectorLeadingConstraint)
        }
        if let selectorBottomConstraint = selectorBottomConstraint {
            removeConstraint(selectorBottomConstraint)
        }
        
        let item = items[selectedIndex]
        
        let horizontalConstrainingView: UIView
        
        if appearance.selectorSpansFullItemWidth {
            horizontalConstrainingView = item
        }
        else {
            horizontalConstrainingView = item.label
        }
        
        selectorLeadingConstraint = NSLayoutConstraint(item: selector, attribute: .leading, relatedBy: .equal, toItem: horizontalConstrainingView, attribute: .leading, multiplier: 1.0, constant: 0)
        
        selectorWidthConstraint = NSLayoutConstraint(item: selector, attribute: .width, relatedBy: .equal, toItem: horizontalConstrainingView, attribute: .width, multiplier: 1.0, constant: 0)
        
        if let selectorOffsetFromLabel = appearance.selectorOffsetFromLabel {
            selectorBottomConstraint = NSLayoutConstraint(item: selector, attribute: .top, relatedBy: .equal, toItem: item.label, attribute: .bottom, multiplier: 1.0, constant: selectorOffsetFromLabel)
        }else {
            selectorBottomConstraint = NSLayoutConstraint(item: selector, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        }
        
        
        addConstraints([selectorWidthConstraint!, selectorLeadingConstraint!, selectorBottomConstraint!])
        
        UIView.animate(withDuration: animation ? 0.3 : 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            [unowned self] in
            self.layoutIfNeeded()
            },completion: nil)
    }
}

