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
    private let labelFrameSize: CGSize = CGSize(width: 31, height: 15)
    private let labelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    private let insetsOffset: CGFloat = 10
    private let minimumBarWidth: CGFloat = 20
    private let minimumBarHeight: CGFloat = 9
    
    func testInitWithFrame_shouldCreateAllSubviews() {
        let view = GTProgressBar(frame: CGRect.zero)
        
        expect(view.subviews).to(haveCount(2))
        expect(view.subviews.first!).to(beAKindOf(UILabel.self))
        
        let backgroundView = view.subviews[self.backgroundViewIndex]
        expect(backgroundView).to(beAKindOf(UIView.self))
        expect(backgroundView.subviews).to(haveCount(1))
        expect(backgroundView.subviews.first!).to(beAKindOf(UIView.self))
    }
    
    func testLayoutSubviews_shouldRenderBakgroundViewNextToLabel() {
        let view = setupView()
        let backgroundView = view.subviews[backgroundViewIndex]
        
        let expectedOrigin = CGPoint(x: labelFrameSize.width + insetsOffset, y: 0)
        expect(backgroundView.frame.origin).to(equal(expectedOrigin))
    }
    
    func testLayoutSubviews_shouldSetBackgroundViewFrameToCorrectSize() {
        let view = setupView()
        let backgroundView = view.subviews[backgroundViewIndex]
        
        let expectedSize = CGSize(width: 100 - labelFrameSize.width - insetsOffset, height: 100)
        expect(backgroundView.frame.size).to(equal(expectedSize))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithDefaultBorder() {
        let view = setupView()
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.layer.borderWidth).to(equal(2))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithRoundedCornersBasedOnTheHeight() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        let backgroundView = view.subviews[backgroundViewIndex]
        
        let expectedRadius: CGFloat = 3.5
        expect(backgroundView.layer.cornerRadius).to(beCloseTo(expectedRadius, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithCorrectCornerRadius() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        let backgroundView = view.subviews[backgroundViewIndex]
        view.cornerRadius = view.bounds.height / 2.0
        view.layoutSubviews()
        
        let expectedRadius: CGFloat = 5.0
        
        expect(backgroundView.layer.cornerRadius).to(beCloseTo(expectedRadius, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithDefaultColors() {
        let view = setupView()
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.layer.borderColor).to(equal(UIColor.black.cgColor))
        expect(backgroundView.backgroundColor).to(equal(UIColor.white))
    }
    
    func testLayoutSubviews_shouldCalculateCorrectFrameForFillView() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        
        let expectedFrame = CGRect(x:4, y: 4, width: 51, height: 92)
        expect(fillView.frame).to(equal(expectedFrame))
    }
    
    func testLayoutSubviews_shouldCalculateCorrectFrameForFillViewWithAntiClockwiseDirection() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100)) { (v: GTProgressBar) in
            v.direction = .anticlockwise
        }
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        
        let expectedFrame = CGRect(x:4, y: 4, width: 51, height: 92)
        expect(fillView.frame).to(equal(expectedFrame))
    }
    
    func testSettingIntDirectionAssignsCorrectDirectionEnumValue() {
        let view = setupView()
        
        view.directionInt = 1
        expect(view.direction).to(equal(GTProgressBarDirection.anticlockwise))
        
        view.directionInt = 0
        expect(view.direction).to(equal(GTProgressBarDirection.clockwise))
    }
    
    func testLayoutSubviews_shouldCalculateCorrectFrameForFillViewWhenRestrictingBarHeight() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 40)) { view in
            view.barMaxHeight = 20
        }
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        
        let expectedFrame = CGRect(x:4, y: 4, width: 51, height: 12)
        expect(fillView.frame).to(equal(expectedFrame))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithRoundedCorners() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        
        let expectedRadius: CGFloat = 0.7
        expect(fillView.layer.cornerRadius).to(beCloseTo(expectedRadius, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithRoundedCornersWhenUsingAntiClockwiseDirection() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10)) { (v: GTProgressBar) in
            v.direction = .anticlockwise
        }
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        
        let expectedRadius: CGFloat = 0.7
        expect(fillView.layer.cornerRadius).to(beCloseTo(expectedRadius, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithCorrectRoundedCorners() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        view.cornerRadius = view.bounds.height / 2.0
        view.layoutSubviews()
        
        let expectedRadius: CGFloat = 5.0
        expect(fillView.layer.cornerRadius).to(beCloseTo(expectedRadius, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithDefaultFillColor() {
        let view = setupView()
        let fillView: UIView = view.subviews[backgroundViewIndex].subviews.first!
        
        expect(fillView.backgroundColor).to(equal(UIColor.black))
    }
    
    func testLayoutSubivews_shouldSetCorrectWidthForFillViewWhenProgressSet() {
        let view = setupView() { v in
            v.progress = 0.5
        }
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        
        let offset: CGFloat = 4
        let expectedFrameWidth: CGFloat = (view.frame.width - insetsOffset - 2*offset - labelFrameSize.width)/2
        expect(fillView.frame.width).to(equal(expectedFrameWidth))
    }
    
    func testLayoutSubivews_shouldSetCorrectPositionForFillViewWhenProgressSetAndAnticlockwiseDirection() {
        let view = setupView() { v in
            v.direction = .anticlockwise
            v.progress = 0.5
        }
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        let backgroundView = view.subviews[backgroundViewIndex]
        
        let offset: CGFloat = 4
        let expectedFrameWidth: CGFloat = (view.frame.width - insetsOffset - 2*offset - labelFrameSize.width)/2
        let expectedFrameOrigin: CGPoint = CGPoint(x: backgroundView.frame.width - expectedFrameWidth - offset, y: offset)
        expect(fillView.frame.width).to(equal(expectedFrameWidth))
        expect(fillView.frame.origin).to(equal(expectedFrameOrigin))
    }
    
    func testLayoutSubivews_shouldNotAllowNegativeValuesForProgress() {
        let view = setupView() { v in
            v.progress = -0.5
        }
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        
        let expectedFrameWidth: CGFloat = 0
        expect(fillView.frame.width).to(equal(expectedFrameWidth))
    }
    
    func testLayoutSubivews_shouldNotAllowProgressToBeGreaterThanOne() {
        let view = setupView() { v in
            v.progress = 1.5
        }

        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        
        let expectedFrameWidth: CGFloat = 51
        expect(fillView.frame.width).to(equal(expectedFrameWidth))
    }
    
    func testShouldAllowSettingProgressBarBorderColor() {
        let view = setupView() { v in
            v.barBorderColor = UIColor.yellow
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        expect(backgroundView.layer.borderColor).to(equal(UIColor.yellow.cgColor))
    }

    func testShouldAllowSettingProgressBarBackgroundColor() {
        let view = setupView() { v in
            v.barBackgroundColor = UIColor.yellow
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        expect(backgroundView.backgroundColor).to(equal(UIColor.yellow))
    }
    
    func testShouldAllowSettingProgressBarFillColor() {
        let view = setupView() { v in
            v.barFillColor = UIColor.blue
        }
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        expect(fillView.backgroundColor).to(equal(UIColor.blue))
    }
    
    func testShouldAllowSettingProgressBarWidth() {
        let view = setupView() { v in
            v.barBorderWidth = 1
        }
        
        let backgroundView = view.subviews[1]
        expect(backgroundView.layer.borderWidth).to(equal(1))
    }
    
    func testShouldRenderFillViewWithCorrectSizeWhenInsetSet() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100)) { v in
            v.barFillInset = 5
        }
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        let insets = labelInsets.left + labelInsets.right
        let expectedOrigin = CGPoint(x: 7, y: 7)
        let expectedSize = CGSize(width:view.frame.size.width - insets -  2*7.0 - labelFrameSize.width, height: 86)
        let expectedFrame = CGRect(origin: expectedOrigin, size: expectedSize)
        expect(fillView.frame).to(equal(expectedFrame))
    }
    
    func testShouldSetCorrectTextInProgressUILabel() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100)) { v in
            v.progress = 0.6
        }
        
        let label: UILabel = view.subviews.first! as! UILabel
        expect(label.text!).to(equal("60%"))
    }
    
    func testShouldSetCorrectFrameSizeForLabel() {
        let view = setupView()
        let label: UILabel = view.subviews.first! as! UILabel
        
        expect(label.frame.size).to(equal(labelFrameSize))
    }
    
    func testShouldAllowToSetInsetsForProgressLabel() {
        let labelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let view = setupView() { v in
            v.progressLabelInsets = labelInsets
        }
        
        let label: UILabel = view.subviews.first! as! UILabel
        
        let expectedLabelX = labelInsets.left
        expect(label.frame.size).to(equal(labelFrameSize))
        expect(label.frame.origin.x).to(equal(expectedLabelX))
    }
    
    func testShouldCenterLabelHorizontallyInView() {
        let view = setupView()
        let label: UILabel = view.subviews.first! as! UILabel
    
        let expectedCenter = CGPoint(x:label.center.x, y:view.frame.size.height/2)
        expect(label.center).to(equal(expectedCenter))
    }

    func testShouldSetCorrectDefaultFontOnProgressLabel() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let label: UILabel = view.subviews.first! as! UILabel
        
        expect(label.font).to(equal(UIFont.systemFont(ofSize: 12)))
    }
    
    func testShouldAllowSettingFontOnTheProgressLabel() {
        let font = UIFont.boldSystemFont(ofSize: 50)
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100)) { v in
            v.font = font
        }
        
        let label: UILabel = view.subviews.first! as! UILabel
        expect(label.font).to(equal(font))
    }
    
    func testShouldCenterTextInTheProgressLabelView() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let label: UILabel = view.subviews.first! as! UILabel
        
        expect(label.textAlignment).to(equal(NSTextAlignment.center))
    }
    
    func testShouldAllowSettingTextColorForProgressLabel() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100)) { v in
            v.labelTextColor = UIColor.red
        }
        
        let label: UILabel = view.subviews.first! as! UILabel
        expect(label.textColor).to(equal(UIColor.red))
    }
    
    func testShouldHideProgressLabelWhenDisplayLabelSetToFalse() {
        let view = setupView() { v in
            v.displayLabel = false
        }
        
        let label = view.subviews.first!
        expect(label.isHidden).to(beTrue())
    }
    
    func testShouldGiveAllSpaceForProgressBarWhenLabelNotDisplayed() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 15)) { v in
            v.displayLabel = false
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size).to(equal(CGSize(width: 100, height: 15)))
        expect(backgroundView.frame.origin).to(equal(CGPoint(x: 0, y: 0)))
    }
    
    func testShouldAllowMaxHeightOfTheBarToBeRestricted() {
        let view = setupView() { v in
            v.barMaxHeight = 10.0
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.height).to(equal(10.0))
    }
    
    func testShouldNotDrawBarHeigherThanParentView() {
        let view = setupView() { v in
            v.barMaxHeight = 1000.0
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.height).to(equal(100.0))
    }
    
    func testShouldCenterBarVerticallyInViewWhenHeightRestrictedWithBarMaxHeight() {
        let view = setupView() { v in
            v.barMaxHeight = 10.0
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        expect(backgroundView.center.y).to(equal(50.0))
    }
    
    func testShouldUpdateProgressWhenAnimatingProgress() {
        let view = setupView()
        view.animateTo(progress: 0.69)
        
        expect(view.progress).to(equal(0.69))
    }
    
    func testShouldUpdateProgressLabeWhenAnimatingProgress() {
        let view = setupView()
        view.animateTo(progress: 0.69)
        
        let label = view.subviews[0] as! UILabel
        expect(label.text).to(equal("69%"))
    }
    
    func testShouldSetCorrectFrameForLabelWhenPlacedOnTheRight() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.right
        }
        
        let label: UILabel = view.subviews.first! as! UILabel
        
        let labelOrigin = CGPoint(x: 100 - 5 - labelFrameSize.width, y: 42.5)
        expect(label.frame.size).to(equal(labelFrameSize))
        expect(label.frame.origin).to(equal(labelOrigin))
    }
    
    func testShouldSetCorrectFrameForBackgroundViewWhenLabelPlacedOnTheRight() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.right
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        let origin = CGPoint.zero
        let frameSize = CGSize(width: 100 - labelFrameSize.width - insetsOffset, height: 100)
        
        expect(backgroundView.frame.size).to(equal(frameSize))
        expect(backgroundView.frame.origin).to(equal(origin))
    }
    
    func testShouldSetCorrectFrameForBackgroundViewWhenNoLabelButPlacementSetOnTheRight() {
        let view = setupView() { view in
            view.displayLabel = false
            view.labelPosition = GTProgressBarLabelPosition.right
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        let origin = CGPoint.zero
        let frameSize = CGSize(width: 100, height: 100)
        
        expect(backgroundView.frame.size).to(equal(frameSize))
        expect(backgroundView.frame.origin).to(equal(origin))
    }
    
    func testShouldCapFrameForBackgroundViewWhenLabelPlacedOnTheRight() {
        let view = setupView() { view in
            view.barMaxHeight = 10
            view.labelPosition = GTProgressBarLabelPosition.right
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.height).to(equal(10))
    }
    
    func testShouldCapFrameForBackgroundViewToParentIfTooLargeAndLabelOnTheRight() {
        let view = setupView() { view in
            view.barMaxHeight = 10000
            view.labelPosition = GTProgressBarLabelPosition.right
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.height).to(equal(100))
    }
    
    func testShouldCapWidthWhenMaxWidthSpecifiedAndLabelOnTheLeft() {
        let view = setupView() { view in
            view.labelPosition = .left
            view.barMaxWidth = 10
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.width).to(equal(10))
    }
    
    func testShouldCapWidthAtAvailableSpaceIfTooBig() {
        let view = setupView() { view in
            view.labelPosition = .left
            view.barMaxWidth = 10000
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.width).to(equal(100 - labelFrameSize.width - labelInsets.left - labelInsets.right))
    }
    
    func testShouldCapWidthWhenMaxWidthSpecifiedAndLabelOnTheRight() {
        let view = setupView() { view in
            view.labelPosition = .right
            view.barMaxWidth = 10
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.width).to(equal(10))
    }
    
    func testShouldCapWidthAtAvailableSpaceIfTooBigWithLabelOnTheRight() {
        let view = setupView() { view in
            view.labelPosition = .right
            view.barMaxWidth = 10000
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.width).to(equal(100 - labelFrameSize.width - labelInsets.left - labelInsets.right))
    }
    
    func testShouldCapWidthWhenMaxWidthSpecifiedAndLabelOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = .bottom
            view.barMaxWidth = 10
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.width).to(equal(10))
    }
    
    func testShouldCapWidthAtAvailableSpaceIfTooBigWithLabelOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = .bottom
            view.barMaxWidth = 10000
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.width).to(equal(100))
    }
    
    func testShouldCapWidthWhenMaxWidthSpecifiedAndLabelOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = .top
            view.barMaxWidth = 10
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.width).to(equal(10))
    }
    
    func testShouldCapWidthAtAvailableSpaceIfTooBigWithLabelOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = .top
            view.barMaxWidth = 10000
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size.width).to(equal(100))
    }
    
    func testShouldSetCorrectFrameForLabelWhenPlacedOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.top
        }
        
        let label: UILabel = view.subviews.first! as! UILabel
        
        let labelOrigin = CGPoint(x: 34.5, y: 0)
        expect(label.frame.size).to(equal(labelFrameSize))
        expect(label.frame.origin).to(equal(labelOrigin))
    }
    
    func testShouldTakeIntoAccountTopInsetWhenCalculatingFrameForLabelPlacedOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.top
            view.progressLabelInsets = UIEdgeInsets(top: 5.0, left: 0, bottom: 0, right: 0)
        }
        
        let label: UILabel = view.subviews.first! as! UILabel
        
        let labelOrigin = CGPoint(x: 34.5, y: 5)
        expect(label.frame.origin).to(equal(labelOrigin))
    }
    
    func testShouldReturnZeroFrameForLabelWhenPlacedOnTheTopButNoDisplay() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.top
            view.displayLabel = false
        }
        
        let label: UILabel = view.subviews.first! as! UILabel
        expect(label.frame.size).to(equal(CGSize.zero))
    }
    
    func testShouldSetCorrectFrameForBackgroundViewWhenLabelPlacedOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.top
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        let origin = CGPoint(x: 0, y: labelFrameSize.height)
        let frameSize = CGSize(width: 100, height: 100 - labelFrameSize.height)
        
        expect(backgroundView.frame.size).to(equal(frameSize))
        expect(backgroundView.frame.origin).to(equal(origin))
    }
    
    func testShouldSetCorrectFrameForBackgroundViewWhenLabelWithInsetsPlacedOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.top
            view.progressLabelInsets = UIEdgeInsets(top: 7.0, left: 0, bottom: 7.0, right: 0)
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        let origin = CGPoint(x: 0, y: labelFrameSize.height + 14.0)
        let frameSize = CGSize(width: 100, height: 100 - labelFrameSize.height - 14)
        
        expect(backgroundView.frame.size).to(equal(frameSize))
        expect(backgroundView.frame.origin).to(equal(origin))
    }
    
    func testShouldSetCorrectFrameForBackgroundViewWhenHeightRestrictedAndLabelOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.top
            view.barMaxHeight = 20.0
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        let origin = CGPoint(x: 0, y: labelFrameSize.height)
        let frameSize = CGSize(width: 100, height: 20)
        
        expect(backgroundView.frame.size).to(equal(frameSize))
        expect(backgroundView.frame.origin).to(equal(origin))
    }
    
     func testShouldSetCorrectFrameForLabelWhenPlacedOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.bottom
        }
         
        let label: UILabel = view.subviews.first! as! UILabel
         
        let labelOrigin = CGPoint(x: 34.5, y: view.frame.height - labelFrameSize.height)
        expect(label.frame.size).to(equal(labelFrameSize))
        expect(label.frame.origin).to(equal(labelOrigin))
     }
 
     func testShouldTakeIntoAccountInsetsWhenCalculatingFrameOriginForLabelPlacedOnTheTop() {
        let insets = UIEdgeInsets(top: 5.0, left: 0, bottom: 5, right: 0)
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.bottom
            view.progressLabelInsets = insets
        }
         
        let label: UILabel = view.subviews.first! as! UILabel
         
        let labelOrigin = CGPoint(x: 34.5, y: view.frame.height - labelFrameSize.height - insets.bottom)
        expect(label.frame.origin).to(equal(labelOrigin))
     }
    
   
    func testShouldReturnZeroFrameForLabelWhenPlacedOnTheBottomButNoDisplay() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.bottom
            view.displayLabel = false
        }

        let label: UILabel = view.subviews.first! as! UILabel
        expect(label.frame.size).to(equal(CGSize.zero))
    }

    
    func testShouldSetCorrectFrameForBackgroundViewWhenLabelPlacedOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.bottom
        }

        let backgroundView = view.subviews[backgroundViewIndex]
        let origin = CGPoint(x: 0, y: 0)
        let frameSize = CGSize(width: view.frame.width, height: view.frame.height - labelFrameSize.height)

        expect(backgroundView.frame.size).to(equal(frameSize))
        expect(backgroundView.frame.origin).to(equal(origin))
    }

    func testShouldSetCorrectFrameForBackgroundViewWhenLabelWithInsetsPlacedOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.bottom
            view.progressLabelInsets = UIEdgeInsets(top: 7.0, left: 0, bottom: 7.0, right: 0)
        }

        let backgroundView = view.subviews[backgroundViewIndex]
        let frameSize = CGSize(width: 100, height: 100 - labelFrameSize.height - 14)

        expect(backgroundView.frame.size).to(equal(frameSize))
        expect(backgroundView.frame.origin).to(equal(CGPoint.zero))
    }
    
    func testShouldSetCorrectFrameForBackgroundViewWhenHeightRestrictedAndLabelOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.bottom
            view.barMaxHeight = 20.0
        }

        let backgroundView = view.subviews[backgroundViewIndex]
        let frameSize = CGSize(width: 100, height: 20)

        expect(backgroundView.frame.size).to(equal(frameSize))
        expect(backgroundView.frame.origin).to(equal(CGPoint.zero))
    }

    func testShouldSetCorrectFrameForProgressLabelWhenBarHeightRestrictedAndLabelOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.bottom
            view.barMaxHeight = 20.0
        }

        let label: UILabel = view.subviews.first! as! UILabel
        let backgroundView = view.subviews[backgroundViewIndex]
        
        let labelOrigin = CGPoint(x: 34.5, y: backgroundView.frame.height)
        
        expect(label.frame.size).to(equal(labelFrameSize))
        expect(label.frame.origin).to(equal(labelOrigin))
    }
    
    func testBackgroundViewTakesTheWholeFrameIfNoLabelPresentAndLabelOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = GTProgressBarLabelPosition.bottom
            view.displayLabel = false
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.frame.size).to(equal(CGSize(width: 100, height: 100)))
        expect(backgroundView.frame.origin).to(equal(CGPoint.zero))
    }
    
    func testSizeToFitCreatesMinimalSizeWithDefaultSettings() {
        let view = setupView()
        view.frame = CGRect.zero
        
        view.sizeToFit()
        
        let height: CGFloat = labelFrameSize.height
        let width: CGFloat = labelFrameSize.width + labelInsets.left + labelInsets.right + minimumBarWidth
    
        
        expect(view.frame.size.height).to(equal(height))
        expect(view.frame.size.width).to(equal(width))
    }
    
    func testSizeToFitChangesFrameHeightWhenBiggerThanNeeded() {
        let view = setupView()
        view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
        
        view.sizeToFit()
        
        let height: CGFloat = labelFrameSize.height
        
        expect(view.frame.size.height).to(equal(height))
        expect(view.frame.size.width).to(equal(100))
    }
    
    func testSizeToFitEnsuresProgressBarIsVisibleWhenVerySmallFontSet() {
        let view = setupView() { view in
            view.font = UIFont.systemFont(ofSize: 1.0)
        }
        
        view.frame = CGRect.zero
        
        view.sizeToFit()
        
        let height: CGFloat = 9.0
        let width: CGFloat = 33.0
        
        expect(view.frame.size.height).to(equal(height))
        expect(view.frame.size.width).to(equal(width))
    }
    
    func testSizeToFitCreatesMinimalSizeWhenLabelNotDisplayed() {
        let view = setupView() { view in
            view.displayLabel = false
        }
        
        view.frame = CGRect.zero
        
        view.sizeToFit()
        
        let height: CGFloat = 9
        let width: CGFloat = minimumBarWidth
        
        expect(view.frame.size.height).to(equal(height))
        expect(view.frame.size.width).to(equal(width))
    }
    
    func testSizeToFitCreatesMinimalSizeWhenLabelWithInsetsOnTop() {
        let view = setupView() { view in
            view.labelPosition = .top
            view.progressLabelInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
        view.frame = CGRect.zero
        view.sizeToFit()
        
        let height: CGFloat = labelFrameSize.height + minimumBarHeight + view.progressLabelInsets.top + view.progressLabelInsets.bottom
        let width: CGFloat = labelFrameSize.width + view.progressLabelInsets.left + view.progressLabelInsets.right
        
        
        expect(view.frame.size.height).to(equal(height))
        expect(view.frame.size.width).to(equal(width))
    }
    
    func testSizeToFitDoesNotChangeFrameWhenBiggerThanMiniumNeededWithLabelOnTop() {
        let view = setupView() { view in
            view.labelPosition = .top
        }
        
        view.sizeToFit()
        
        expect(view.frame.size.height).to(equal(100))
        expect(view.frame.size.width).to(equal(100))
    }
    
    func testSizeToFitChangeFrameHeightWhenMaxBarHeightSpecifiedWithLabelOnTop() {
        let view = setupView() { view in
            view.labelPosition = .top
            view.barMaxHeight = 30
        }
        
        view.sizeToFit()
        
        expect(view.frame.size.height).to(equal(labelFrameSize.height + 30))
        expect(view.frame.size.width).to(equal(100))
    }
    
    func testSizeToFitEnsuresMinimumBarWidthWhenSmallFontAndSmallFrame() {
        let view = setupView() { view in
            view.labelPosition = .top
            view.font = UIFont.systemFont(ofSize: 1)
        }
        
        view.frame = CGRect.zero
        view.sizeToFit()
        
        expect(view.frame.size.width).to(equal(20))
    }
    
    
    func testSizeToFitCreatesMinimalSizeWhenLabelWithInsetsOnBottom() {
        let view = setupView() { view in
            view.labelPosition = .bottom
            view.progressLabelInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
        view.frame = CGRect.zero
        view.sizeToFit()
        
        let height: CGFloat = labelFrameSize.height + minimumBarHeight + view.progressLabelInsets.top + view.progressLabelInsets.bottom
        let width: CGFloat = labelFrameSize.width + view.progressLabelInsets.left + view.progressLabelInsets.right
        
        
        expect(view.frame.size.height).to(equal(height))
        expect(view.frame.size.width).to(equal(width))
    }
    
    func testSizeToFitDoesNotChangeFrameWhenBiggerThanMiniumNeededWithLabelOnBottom() {
        let view = setupView() { view in
            view.labelPosition = .bottom
        }
        
        view.sizeToFit()
        
        expect(view.frame.size.height).to(equal(100))
        expect(view.frame.size.width).to(equal(100))
    }

    func testSizeToFitChangeFrameHeightWhenMaxBarHeightSpecifiedWithLabelOnBottom() {
        let view = setupView() { view in
            view.labelPosition = .bottom
            view.barMaxHeight = 30
        }
        
        view.sizeToFit()
        
        expect(view.frame.size.height).to(equal(labelFrameSize.height + 30))
        expect(view.frame.size.width).to(equal(100))
    }

    func testSizeToFitEnsuresMinimumBarWidthWhenSmallFontAndSmallFrameWithLabelOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = .bottom
            view.font = UIFont.systemFont(ofSize: 1)
        }
        
        view.frame = CGRect.zero
        view.sizeToFit()
        
        expect(view.frame.size.width).to(equal(20))
    }
    
    func testSettingProgressBarLabelInsetLeftChangesTheInsetsUsedByTheConrol() {
        let view = setupView() { view in
            view.progressLabelInsetLeft = 999
        }
        
        expect(view.progressLabelInsets.left).to(equal(999))
    }
    
    func testSettingProgressBarLabelInsetLeftDoesNotAllowNegativeValues() {
        let view = setupView() { view in
            view.progressLabelInsetLeft = -999
        }
        
        expect(view.progressLabelInsets.left).to(equal(0))
    }
    
    func testSettingProgressBarLabelInsetRightChangesTheInsetsUsedByTheConrol() {
        let view = setupView() { view in
            view.progressLabelInsetRight = 999
        }
        
        expect(view.progressLabelInsets.right).to(equal(999))
    }
    
    func testSettingProgressBarLabelInsetRightDoesNotAllowNegativeValues() {
        let view = setupView() { view in
            view.progressLabelInsetRight = -999
        }
        
        expect(view.progressLabelInsets.right).to(equal(0))
    }
    
    func testSettingProgressBarLabelInsetTopChangesTheInsetsUsedByTheControl() {
        let view = setupView() { view in
            view.progressLabelInsetTop = 999
        }
        
        expect(view.progressLabelInsets.top).to(equal(999))
    }
    
    func testSettingProgressBarLabelInsetTopDoesNotAllowNegativeValues() {
        let view = setupView() { view in
            view.progressLabelInsetTop = -999
        }
        
        expect(view.progressLabelInsets.top).to(equal(0))
    }
    
    func testSettingProgressBarLabelInsetBottomChangesTheInsetsUsedByTheConrol() {
        let view = setupView() { view in
            view.progressLabelInsetBottom = 999
        }
        
        expect(view.progressLabelInsets.bottom).to(equal(999))
    }
    
    func testSettingProgressBarLabelInsetBottomDoesNotAllowNegativeValues() {
        let view = setupView() { view in
            view.progressLabelInsetBottom = -999
        }
        
        expect(view.progressLabelInsets.bottom).to(equal(0))
    }
    
    func testSettingIntOrientationAssignsCorrectOrientationEnum() {
        let view = setupView()
        
        view.orientationInt = 1
        expect(view.orientation).to(equal(GTProgressBarOrientation.vertical))
        
        view.orientationInt = 0
        expect(view.orientation).to(equal(GTProgressBarOrientation.horizontal))
    }
    
    func testFillViewHasTheSameFrameAsBackgroundViewWhenNoInsetsSetAndFullProgressSet() {
        let view = setupView() { view in
            view.barFillInset = 0
            view.progress = 1
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        let fillView = backgroundView.subviews.first!
        
        expect(fillView.frame.origin).to(equal(CGPoint.zero))
        expect(fillView.frame.size).to(equal(backgroundView.frame.size))
    }
    
    func testSettingBarMaxHeightIntPopulatesTheBarMaxHeightVariable() {
        let view = setupView()
        
        view.barMaxHeight = nil
        view.barMaxHeightInt = 2
        
        expect(view.barMaxHeight!).to(equal(CGFloat(view.barMaxHeightInt)))
    }
    
    func testSettingBarMaxHeightIntOfZeroMakesTheBarMaxHeightVariableAbsent() {
        let view = setupView()
        
        view.barMaxHeight = 2.0
        view.barMaxHeightInt = 0
        
        expect(view.barMaxHeight).to(beNil())
    }
    
    private func setupView(frame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), configure: (GTProgressBar) -> Void = { _ in }
) -> GTProgressBar {
        let view = GTProgressBar(frame: frame)
        configure(view)
        view.layoutSubviews()
        
        return view
    }
    
}
