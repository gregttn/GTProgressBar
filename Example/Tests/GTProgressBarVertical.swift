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
    private let labelFrameSize: CGSize = CGSize(width: 31, height: 15)
    private let labelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    private let insetsOffset: CGFloat = 10
    private let minimumBarWidth: CGFloat = 20
    private let minimumBarHeight: CGFloat = 9
    
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
    
    
    private func setupView(frame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), configure: (GTProgressBar) -> Void = { _ in }
        ) -> GTProgressBar {
        let view = GTProgressBar(frame: frame)
        view.orientation = GTProgressBarOrientation.vertical
        
        configure(view)
        view.layoutSubviews()
        
        return view
    }
}
