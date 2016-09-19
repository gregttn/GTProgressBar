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
    
    func testInitWithFrame_shouldCreateProgressBarBackgroundAndFillViews() {
        let view = GTProgressBar(frame: CGRect.zero)
        
        expect(view.subviews).to(haveCount(2))
    }
    
    func testLayoutSubviews_shouldSetBackgroundViewFrameToSameSizeAsTheParent() {
        let frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        let view = GTProgressBar(frame: frame)
        view.layoutSubviews()
        
        let expectedFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        expect(view.subviews.first!.frame).to(equal(expectedFrame))
    }
    
    func testLayoutSubviews_shouldCalculateCorrectFrameForFillView() {
        let frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        let view = GTProgressBar(frame: frame)
        view.layoutSubviews()
        
        let expectedFrame = CGRect(x: 4, y: 4, width: 92, height: 92)
        expect(view.subviews[1].frame).to(equal(expectedFrame))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithBorder() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = GTProgressBar(frame: frame)
        view.layoutSubviews()
    
        let backgroundView = view.subviews.first!
        
        expect(backgroundView.layer.borderWidth).to(equal(2))
        expect(backgroundView.layer.borderColor).to(equal(UIColor.black.cgColor))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithFillColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = GTProgressBar(frame: frame)
        view.layoutSubviews()
        
        expect(view.subviews[1].backgroundColor).to(equal(UIColor.black))
    }
    
}
