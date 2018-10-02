//
//  GTProgressBar.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 19/09/2016.

import UIKit

@IBDesignable
public class GTProgressBar: UIView {
    private let minimumProgressBarWidth: CGFloat = 20
    private let minimumProgressBarFillHeight: CGFloat = 1
    private let backgroundView = NoClearView()
    private let fillView = NoClearView()
    private let progressLabel = UILabel()
    private var _progress: CGFloat = 1
    
    public var font: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            progressLabel.font = font
            self.setNeedsLayout()
        }
    }
    
    public var progressLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var progressLabelInsetLeft: CGFloat = 0.0 {
        didSet {
            self.progressLabelInsets.left = max(0.0, progressLabelInsetLeft)
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var progressLabelInsetRight: CGFloat = 0.0 {
        didSet {
            self.progressLabelInsets.right = max(0.0, progressLabelInsetRight)
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var progressLabelInsetTop: CGFloat = 0.0 {
        didSet {
            self.progressLabelInsets.top = max(0.0, progressLabelInsetTop)
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var progressLabelInsetBottom: CGFloat = 0.0 {
        didSet {
            self.progressLabelInsets.bottom = max(0.0, progressLabelInsetBottom)
            self.setNeedsLayout()
        }
    }
    
    public var barMaxHeight: CGFloat? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barMaxHeightInt: Int = 0 {
        didSet {
            self.barMaxHeight = barMaxHeightInt == 0 ? nil : CGFloat(barMaxHeightInt)
        }
    }
    
    public var barMaxWidth: CGFloat? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barMaxWidthInt: Int = 0 {
        didSet {
            self.barMaxWidth = barMaxWidthInt == 0 ? nil : CGFloat(barMaxWidthInt)
        }
    }
    
    @IBInspectable
    public var barBorderColor: UIColor = UIColor.black {
        didSet {
            backgroundView.layer.borderColor = barBorderColor.cgColor
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBackgroundColor: UIColor = UIColor.white {
        didSet {
            backgroundView.backgroundColor = barBackgroundColor
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barFillColor: UIColor = UIColor.black {
        didSet {
            fillView.backgroundColor = barFillColor
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBorderWidth: CGFloat = 2 {
        didSet {
            backgroundView.layer.borderWidth = barBorderWidth
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barFillInset: CGFloat = 2 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var progress: CGFloat {
        get {
            return self._progress
        }
        
        set {
            self._progress = min(max(newValue,0), 1)
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable
    public var labelTextColor: UIColor = UIColor.black {
        didSet {
            progressLabel.textColor = labelTextColor
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var displayLabel: Bool = true {
        didSet {
            self.progressLabel.isHidden = !self.displayLabel
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.masksToBounds = cornerRadius != 0.0
            self.layer.cornerRadius = cornerRadius
            self.setNeedsLayout()
        }
    }
    
    public var labelPosition: GTProgressBarLabelPosition = GTProgressBarLabelPosition.left {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var labelPositionInt: Int = 0 {
        didSet {
            let enumPosition = GTProgressBarLabelPosition(rawValue: labelPositionInt)
            
            if let position = enumPosition {
                self.labelPosition = position
            }
        }
    }
    
    public var orientation: GTProgressBarOrientation = GTProgressBarOrientation.horizontal {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var orientationInt: Int = 0 {
        didSet {
            let enumOrientation = GTProgressBarOrientation(rawValue: orientationInt)
            
            if let orientation = enumOrientation {
                self.orientation = orientation
            }
        }
    }
    
    public var direction: GTProgressBarDirection = GTProgressBarDirection.clockwise {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var directionInt: Int = 0 {
        didSet {
            let enumDirection = GTProgressBarDirection(rawValue: directionInt)
            
            if let direction = enumDirection {
                self.direction = direction
            }
        }
    }
    
    public var cornerType: GTProgressBarCornerType = GTProgressBarCornerType.rounded {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var cornerTypeInt: Int = GTProgressBarCornerType.rounded.rawValue {
        didSet {
            let enumCornerType = GTProgressBarCornerType(rawValue: cornerTypeInt)
            
            if let type = enumCornerType {
                self.cornerType = type
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareSubviews()
    }
    
    private func prepareSubviews() {
        progressLabel.textAlignment = NSTextAlignment.center
        progressLabel.font = font
        progressLabel.textColor = labelTextColor
        addSubview(progressLabel)

        backgroundView.backgroundColor = barBackgroundColor
        backgroundView.layer.borderWidth = barBorderWidth
        backgroundView.layer.borderColor = barBorderColor.cgColor
        addSubview(backgroundView)
        
        fillView.backgroundColor = barFillColor
        backgroundView.addSubview(fillView)
    }
    
    public override func layoutSubviews() {
        updateProgressLabelText()
        updateViewsLocation()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return createFrameCalculator().sizeThatFits(size)
    }
    
    private func updateViewsLocation() {
        let frameCalculator: FrameCalculator = createFrameCalculator()
        
        progressLabel.frame = frameCalculator.labelFrame()
        frameCalculator.centerLabel(label: progressLabel)

        backgroundView.frame = frameCalculator.backgroundViewFrame()
        backgroundView.layer.cornerRadius = cornerRadiusFor(view: backgroundView)
        frameCalculator.centerBar(bar: backgroundView)

        fillView.frame = frameCalculator.fillViewFrameFor(progress: _progress)
        fillView.layer.cornerRadius = cornerRadiusFor(view: fillView)
    }
    
    private func createFrameCalculator() -> FrameCalculator {
        switch labelPosition {
        case .right:
            return LabelRightFrameCalculator(progressBar: self)
        case .top:
            return LabelTopFrameCalculator(progressBar: self)
        case .bottom:
            return LabelBottomFrameCalculator(progressBar: self)
        default:
            return LabelLeftFrameCalculator(progressBar: self)
        }
    }
    
    private func updateProgressLabelText() {
        progressLabel.text = "\(Int(round(_progress * 100)))%"
    }
    
    public func animateTo(progress: CGFloat, completion: (() -> Void)? = nil) {
        let newProgress = min(max(progress,0), 1)
        let fillViewFrame = createFrameCalculator().fillViewFrameFor(progress: newProgress)
        let frameChange: () -> () = {
            self.fillView.frame = fillViewFrame
            self._progress = newProgress
            self.updateProgressLabelText()
        }
        
        if #available(iOS 10.0, *) {
            let animation = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut, animations: frameChange)
            animation.addCompletion { (position) in
                completion?()
            }
            animation.startAnimation()
        } else {
            #if swift(>=4.2)
            let animationOptions = UIView.AnimationOptions.curveEaseInOut
            #else
            let animationOptions = UIViewAnimationOptions.curveEaseInOut
            #endif

            UIView.animate(withDuration: 0.8,
                delay: 0,
                options: [animationOptions],
                animations: frameChange,
                completion: { (finished) in 
                    completion?()
            })
        }
    }
    
    private func cornerRadiusFor(view: UIView) -> CGFloat {
        if cornerType == .square {
            return 0.0
        }
        
        if cornerRadius != 0.0 {
            return cornerRadius
        }
        
        switch orientation {
        case .horizontal:
            return view.frame.height / 2 * 0.7
        case .vertical:
            return view.frame.width / 2 * 0.7
        }
    }
    
    class NoClearView: UIView {
        override public var backgroundColor: UIColor? {
            didSet {
                if backgroundColor == nil || backgroundColor == UIColor.clear {
                    backgroundColor = oldValue
                }
            }
        }
    }


}

