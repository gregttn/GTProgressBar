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
    private let backgroundView = UIView()
    private let fillView = UIView()
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
        addSubview(fillView)
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
        frameCalculator.center(view: progressLabel, parent: self)

        backgroundView.frame = frameCalculator.backgroundViewFrame()
        backgroundView.layer.cornerRadius = cornerRadiusFor(view: backgroundView)
        
        if (barMaxHeight != nil) {
            frameCalculator.center(view: backgroundView, parent: self)
        }
        
        fillView.frame = fillViewFrameFor(progress: _progress)
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
        progressLabel.text = "\(Int(_progress * 100))%"
    }
    
    public func animateTo(progress: CGFloat) {
        let newProgress = min(max(progress,0), 1)
        let fillViewFrame = fillViewFrameFor(progress: newProgress)
        let frameChange: () -> () = {
            self.fillView.frame.size.width = fillViewFrame.size.width
            self._progress = newProgress
        }
        
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut, animations: frameChange)
                .startAnimation()
        } else {
            UIView.animate(withDuration: 0.8,
                delay: 0,
                options: [UIViewAnimationOptions.curveEaseInOut],
                animations: frameChange,
                completion: nil);
        }
    }
    
    private func fillViewFrameFor(progress: CGFloat) -> CGRect {
        let offset = barBorderWidth + barFillInset
        let fillFrame = backgroundView.frame.insetBy(dx: offset, dy: offset)
        let fillFrameAdjustedSize = CGSize(width: fillFrame.width * progress, height: fillFrame.height)
        
        return CGRect(origin: fillFrame.origin, size: fillFrameAdjustedSize)
    }
    
    private func cornerRadiusFor(view: UIView) -> CGFloat {
        if cornerRadius != 0.0 {
            return cornerRadius
        }
        
        return view.frame.height / 2 * 0.7
    }
}
