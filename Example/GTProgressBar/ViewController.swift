//
//  ViewController.swift
//  GTProgressBar
//
//  Created by gregttn on 09/19/2016.
//  Copyright (c) 2016 gregttn. All rights reserved.
//

import UIKit
import GTProgressBar

class ViewController: UIViewController {
    @IBOutlet var labelRightProgressBars: [GTProgressBar]!

    @IBOutlet weak var progressBar: GTProgressBar!
    @IBOutlet weak var progressBarLargerFont: GTProgressBar!
    @IBOutlet weak var animatedProgressBar: GTProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressBar.progress = 1
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        progressBarLargerFont.font = UIFont.boldSystemFont(ofSize: 18)
        progressBarLargerFont.barMaxHeight = 12
        progressBarLargerFont.cornerRadius = (progressBarLargerFont.barMaxHeight ?? progressBarLargerFont.bounds.height) / 2.0
        
        labelRightProgressBars.forEach { progressBar in
            progressBar.labelPostion = GTProgressBarLabelPostion.right
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func animateProgressBarButtonPressed(_ sender: Any) {
        let newProgress: CGFloat = animatedProgressBar.progress == 0.75 ? 0.45 : 0.75
        animatedProgressBar.animateTo(progress: newProgress)
    }
}

