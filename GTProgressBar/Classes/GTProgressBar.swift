//
//  GTProgressBar.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 19/09/2016.

import UIKit

@IBDesignable
public class GTProgressBar: UIView {
    private let backgroundView = UIView()
    private let fillView = UIView()
    private let progressLabel = UILabel()
    private var _progress: CGFloat = 1
    
    public var font: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    public var progressLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) {
        didSet {
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
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBackgroundColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barFillColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBorderWidth: CGFloat = 2 {
        didSet {
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareSubviews()
    }
    
    private func prepareSubviews() {
        addSubview(progressLabel)
        addSubview(backgroundView)
        addSubview(fillView)
    }
    
    public override func layoutSubviews() {
        setupProgressLabel()
        setupBackgroundView()
        setupFillView()
    }
    
    private func setupProgressLabel() {
        progressLabel.text = "\(Int(_progress * 100))%"
        let origin = CGPoint(x: progressLabelInsets.left, y: 0)
        progressLabel.frame = CGRect(origin: origin, size: sizeForLabel())
        progressLabel.font = font
        progressLabel.textAlignment = NSTextAlignment.center
        progressLabel.textColor = labelTextColor
        
        centerVerticallyInView(view: progressLabel)
    }
    
    private func setupBackgroundView() {
        let xOffset = backgroundViewXOffset()
        let height = min(barMaxHeight ?? frame.size.height, frame.size.height)
        let size = CGSize(width: frame.size.width - xOffset, height: height)
        let origin = CGPoint(x: xOffset, y: 0)
        
        backgroundView.frame = CGRect(origin: origin, size: size)
        backgroundView.backgroundColor = barBackgroundColor
        backgroundView.layer.borderWidth = barBorderWidth
        backgroundView.layer.borderColor = barBorderColor.cgColor
        backgroundView.layer.cornerRadius = cornerRadiusFor(view: backgroundView)
        
        if let _ = barMaxHeight {
            centerVerticallyInView(view: backgroundView)
        }
    }
    
    private func setupFillView() {
        fillView.frame = fillViewFrameFor(progress: _progress)
        fillView.backgroundColor = barFillColor
        fillView.layer.cornerRadius = cornerRadiusFor(view: fillView)
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
    
    private func backgroundViewXOffset() -> CGFloat {
        return displayLabel ? progressLabel.frame.width + progressLabelInsets.left + progressLabelInsets.right : 0.0
    }
    
    private func cornerRadiusFor(view: UIView) -> CGFloat {
        if cornerRadius != 0.0 {
            return cornerRadius
        }
        
        return view.frame.height / 2 * 0.7
    }
    
    private func sizeForLabel() -> CGSize {
        let text: NSString = "100%"
        let textSize = text.size(attributes: [NSFontAttributeName : font])
        
        return CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
    }
    
    private func centerVerticallyInView(view: UIView) {
        let center = self.convert(self.center, from: self.superview)
        view.center = CGPoint(x: view.center.x, y: center.y)
    }
}
