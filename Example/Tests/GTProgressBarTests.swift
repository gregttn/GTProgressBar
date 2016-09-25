//
//  GTProgressBarTests.swift
//  GTProgressBar
//
//  Created by Grzegorz Tatarzyn on 19/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import GTProgressBar

class GTProgressBarTests: XCTestCase {
    private let backgroundViewIndex = 1
    private let fillViewIndex = 2
    private var defaultFontSize: CGSize {
        let font = UIFont.systemFont(ofSize: 12)
        let text: NSString = "100%"
        let textSize = text.size(attributes: [NSFontAttributeName: font])
        
        return  CGSize(width: ceil(textSize.width), height: ceil(textSize.height	))
    }
    
    func testInitWithFrame_shouldCreateAllSubviews() {
        let view = GTProgressBar(frame: CGRect.zero)
        
        expect(view.subviews).to(haveCount(3))
        expect(view.subviews.first!).to(beAKindOf(UILabel.self))
        expect(view.subviews[1]).to(beAKindOf(UIView.self))
        expect(view.subviews[2]).to(beAKindOf(UIView.self))
    }
    
    func testLayoutSubviews_shouldRenderBakgroundViewNextToLabel() {
        let view = setupView()
        let backgroundView = view.subviews[backgroundViewIndex]
        
        let expectedOrigin = CGPoint(x: defaultFontSize.width, y: 0)
        
        expect(backgroundView.frame.origin).to(equal(expectedOrigin))
    }
    
    func testLayoutSubviews_shouldSetBackgroundViewFrameToCorrectSize() {
        let view = setupView()
        let backgroundView = view.subviews[backgroundViewIndex]
        
        let expectedSize = CGSize(width: 100 - defaultFontSize.width, height: 100)
        expect(backgroundView.frame.size).to(equal(expectedSize))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithDefaultBorder() {
        let view = setupView()
        let backgroundView = view.subviews[1]
        
        expect(backgroundView.layer.borderWidth).to(equal(2))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithRoundedCorners() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        let backgroundView = view.subviews[backgroundViewIndex]
        
        let expectedRoundedCorners: CGFloat = 3.5
        expect(backgroundView.layer.cornerRadius).to(beCloseTo(expectedRoundedCorners, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithDefaultColors() {
        let view = setupView()
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.layer.borderColor).to(equal(UIColor.black.cgColor))
        expect(backgroundView.backgroundColor).to(equal(UIColor.white))
    }
    
    func testLayoutSubviews_shouldCalculateCorrectFrameForFillView() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let fillView = view.subviews[fillViewIndex]
        
        let expectedFrame = CGRect(x:35, y: 4, width: 61, height: 92)
        expect(fillView.frame).to(equal(expectedFrame))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithRoundedCorners() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        let fillView = view.subviews[fillViewIndex]
        
        let expectedRoundedCorners: CGFloat = 0.7
        expect(fillView.layer.cornerRadius).to(beCloseTo(expectedRoundedCorners, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithDefaultFillColor() {
        let view = setupView()
        
        expect(view.subviews[2].backgroundColor).to(equal(UIColor.black))
    }
    
    func testLayoutSubivews_shouldSetCorrectWidthForFillViewWhenProgressSet() {
        let view = setupView()
        view.progress = 0.5
        view.layoutSubviews()
        let fillView = view.subviews[fillViewIndex]
        let offset: CGFloat = 4
        
        let expectedFrameWidth: CGFloat = (view.frame.width - 2*offset - defaultFontSize.width)/2
        expect(fillView.frame.width).to(equal(expectedFrameWidth))
    }
    
    func testLayoutSubivews_shouldNotAllowNegativeValuesForProgress() {
        let view = setupView()
        view.progress = -0.5
        view.layoutSubviews()
        let fillView = view.subviews[fillViewIndex]
        
        let expectedFrameWidth: CGFloat = 0
        expect(fillView.frame.width).to(equal(expectedFrameWidth))
    }
    
    func testLayoutSubivews_shouldNotAllowProgressToBeGreaterThanOne() {
        let view = setupView()
        view.progress = 1.5
        view.layoutSubviews()
        let fillView = view.subviews[fillViewIndex]
        
        let expectedFrameWidth: CGFloat = 61
        expect(fillView.frame.width).to(equal(expectedFrameWidth))
    }
    
    func testShouldAllowSettingProgressBarBorderColor() {
        let view = setupView()
        view.barBorderColor = UIColor.yellow
        
        view.layoutSubviews()
        
        let backgroundView = view.subviews[backgroundViewIndex]
        expect(backgroundView.layer.borderColor).to(equal(UIColor.yellow.cgColor))
    }

    func testShouldAllowSettingProgressBarBackgroundColor() {
        let view = setupView()
        view.barBackgroundColor = UIColor.yellow
        
        view.layoutSubviews()
        
        let backgroundView = view.subviews[backgroundViewIndex]
        expect(backgroundView.backgroundColor).to(equal(UIColor.yellow))
    }
    
    func testShouldAllowSettingProgressBarFillColor() {
        let view = setupView()
        view.barFillColor = UIColor.blue
        
        view.layoutSubviews()
        
        let fillView = view.subviews[fillViewIndex]
        expect(fillView.backgroundColor).to(equal(UIColor.blue))
    }
    
    func testShouldAllowSettingProgressBarWidth() {
        let view = setupView()
        view.barBorderWidth = 1
        
        view.layoutSubviews()
        
        let backgroundView = view.subviews[1]
        expect(backgroundView.layer.borderWidth).to(equal(1))
    }
    
    func testShouldRenderFillViewWithCorrectSizeWhenInsetSet() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        view.barFillInset = 5
        
        view.layoutSubviews()
        
        let fillView = view.subviews[fillViewIndex]
        let expectedOrigin = CGPoint(x: 7 + defaultFontSize.width, y: 7)
        let expectedSize = CGSize(width:view.frame.size.width - 2*7.0 - defaultFontSize.width, height: 86)
        let expectedFrame = CGRect(origin: expectedOrigin, size: expectedSize)
        expect(fillView.frame).to(equal(expectedFrame))
    }
    
    func testShouldSetCorrectTextInProgressUILabel() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        view.progress = 0.6
        
        view.layoutSubviews()
        
        let label: UILabel = view.subviews.first! as! UILabel
        expect(label.text!).to(equal("60%"))
    }
    
    func testShouldSetCorrectFrameSizeForLabel() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let label: UILabel = view.subviews.first! as! UILabel
        
        expect(label.frame.size).to(equal(defaultFontSize))
    }

    func testShouldSetCorrectDefaultFontOnProgressLabel() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let label: UILabel = view.subviews.first! as! UILabel
        
        expect(label.font).to(equal(UIFont.systemFont(ofSize: 12)))
    }
    
    func testShouldAllowSettingFontOnTheProgressLabel() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let font = UIFont.boldSystemFont(ofSize: 50)
        
        view.font = font
        view.layoutSubviews()
        
        let label: UILabel = view.subviews.first! as! UILabel
        
        expect(label.font).to(equal(font))
    }
    
    private func setupView(frame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)) -> GTProgressBar {
        let view = GTProgressBar(frame: frame)
        view.layoutSubviews()
        
        return view
    }
    
}
