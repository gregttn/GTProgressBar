//
//  GTProgressBarVertical.swift
//  GTProgressBar
//
//  Created by Grzegorz Tatarzyn on 04/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import GTProgressBar

class GTProgressBarVertical: XCTestCase {
    private let backgroundViewIndex = 1
    private let labelViewIndex = 0
    private let labelFrameSize: CGSize = CGSize(width: 31, height: 15)
    private let labelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    private let insetsOffset: CGFloat = 10
    private let minimumBarWidth: CGFloat = 20
    private let minimumBarHeight: CGFloat = 20
    
    func testShouldCalculateCorrectFramesWhenVerticalBarWithoutLabel() {
        let view = setupView() { view in
            view.displayLabel = false
            view.progress = 0.5
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        let expectedBackgroundFrame = CGRect(origin: CGPoint.zero, size: view.frame.size)
        expect(backgroundView.frame).to(equal(expectedBackgroundFrame))
        
        let fillView = backgroundView.subviews.first!
        let expectedFillViewFrame = CGRect(origin: CGPoint(x: 4, y: 50), size: CGSize(width:92, height: 46))
        expect(fillView.frame).to(equal(expectedFillViewFrame))
    }
    
    func testShouldCalculateRoundedCornerBasedOnWidth() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 20, height: 100)) { view in
            view.displayLabel = false
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.layer.cornerRadius).to(equal(7))
    }
    
    func testShouldChangePositionAndHeightOfFillViewWhenUsingAnimateTo() {
        let view = setupView() { view in
            view.displayLabel = false
            view.progress = 0.1
        }
        
        view.animateTo(progress: 0.5)
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        let expectedFillViewFrame = CGRect(origin: CGPoint(x: 4, y: 50), size: CGSize(width:92, height: 46))
        expect(fillView.frame).to(equal(expectedFillViewFrame))
    }
    
    func testShouldChangeCalculateCorrectFrameForFillViewWhenAnticlockwiseDirectionUsed() {
        let view = setupView() { view in
            view.displayLabel = false
            view.progress = 0.1
            view.direction = .anticlockwise
        }
        
        view.animateTo(progress: 0.5)
        
        let fillView = view.subviews[backgroundViewIndex].subviews.first!
        let expectedFillViewFrame = CGRect(origin: CGPoint(x: 4, y: 4), size: CGSize(width:92, height: 46))
        expect(fillView.frame).to(equal(expectedFillViewFrame))
    }
    
    func testSizeToFitCreatesMinimalSizeWithHorizontalLabelAlignment() {
        let view = setupView()
        
        view.frame = CGRect.zero
        
        view.sizeToFit()
        
        let width: CGFloat = labelFrameSize.width + labelInsets.left + labelInsets.right + minimumBarWidth
        
        expect(view.frame.size.height).to(equal(minimumBarHeight))
        expect(view.frame.size.width).to(equal(width))
    }
    
    func testSizeToFitCreatesMinimalSizeWithVerticalLabelAlignment() {
        let view = setupView() { view in
            view.labelPosition = .top
        }
        
        view.frame = CGRect.zero
        
        view.sizeToFit()
        
        let height: CGFloat = labelFrameSize.height + labelInsets.top + labelInsets.bottom + minimumBarHeight
        let width: CGFloat = labelFrameSize.width + labelInsets.left + labelInsets.right
        
        expect(view.frame.size.height).to(equal(height))
        expect(view.frame.size.width).to(equal(width))
    }
    
    func testLabelCenteredHorizontallyWhenLabelOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = .top
        }
        
        let label = view.subviews[labelViewIndex]
        
        expect(label.center.x).to(equal(view.center.x))
    }
    
    func testLabelCenteredHorizontallyWhenLabelOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = .bottom
        }
        
        let label = view.subviews[labelViewIndex]
        
        expect(label.center.x).to(equal(view.center.x))
    }
    
    func testLabelCenteredVerticallyWhenLabelOnTheRight() {
        let view = setupView() { view in
            view.labelPosition = .right
        }
        
        let label = view.subviews[labelViewIndex]
        
        expect(label.center.y).to(equal(view.center.y))
    }
    
    func testLabelCenteredVerticallyWhenLabelOnTheLeft() {
        let view = setupView() { view in
            view.labelPosition = .left
        }
        
        let label = view.subviews[labelViewIndex]
        
        expect(label.center.y).to(equal(view.center.y))
    }
    
    func testBarCenteredHorizontally() {
        let view = setupView()
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.center.y).to(equal(view.center.y))
    }
    
    func testBarCenteredVerticallyWhenNoLabel() {
        let view = setupView() { view in
            view.displayLabel = false
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.center.x).to(equal(view.center.x))
    }
    
    func testBarCenteredVerticallyWhenNoLabelAndWidthRestricted() {
        let view = setupView() { view in
            view.displayLabel = false
            view.barMaxWidth = 20
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.center.x).to(equal(view.center.x))
    }
    
    func testBarCenteredVerticallyWhenWidthRestrictedAndLabelOnTheTop() {
        let view = setupView() { view in
            view.labelPosition = .top
            view.barMaxWidth = 20
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.center.x).to(equal(view.center.x))
    }
    
    func testBarCenteredVerticallyWhenWidthRestrictedAndLabelOnTheBottom() {
        let view = setupView() { view in
            view.labelPosition = .top
            view.barMaxWidth = 20
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        
        expect(backgroundView.center.x).to(equal(view.center.x))
    }
    
    func testFillViewHasTheSameFrameAsBackgroundViewWhenNoInsetsSetAndFullProgressSet() {
        let view = setupView() { view in
            view.labelPosition = .top
            view.barFillInset = 0
            view.progress = 1
        }
        
        let backgroundView = view.subviews[backgroundViewIndex]
        let fillView = backgroundView.subviews.first!
        
        expect(fillView.frame.origin).to(equal(CGPoint.zero))
        expect(fillView.frame.size).to(equal(backgroundView.frame.size))
    }
    
    func testSettingBarMaxWidthIntPopulatesTheBarMaxWidthVariable() {
        let view = setupView()
        
        view.barMaxWidth = nil
        view.barMaxWidthInt = 2
        
        expect(view.barMaxWidth!).to(equal(CGFloat(view.barMaxWidthInt)))
    }
    
    func testSettingBarMaxWidthIntOfZeroMakesTheBarMaxHeightVariableAbsent() {
        let view = setupView()
        
        view.barMaxWidth = 2.0
        view.barMaxWidthInt = 0
        
        expect(view.barMaxWidth).to(beNil())
    }
    
    private func setupView(frame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), configure: (GTProgressBar) -> Void = { _ in }
        ) -> GTProgressBar {
        let view = GTProgressBar(frame: frame)
        view.orientation = GTProgressBarOrientation.vertical
        
        configure(view)
        view.layoutSubviews()
        
        return view
    }
}
