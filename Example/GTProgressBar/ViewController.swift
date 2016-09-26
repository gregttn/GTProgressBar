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

    @IBOutlet weak var progressBar: GTProgressBar!
    @IBOutlet weak var orangeProgressBar: GTProgressBar!
    @IBOutlet weak var redProgressBar: GTProgressBar!
    @IBOutlet weak var zeroProgressBar: GTProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        // Do any additional setup after loading the view, typically from a nib.
        progressBar.progress = 1
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.progressLabelInsets = labelInsets
        
        orangeProgressBar.progressLabelInsets = labelInsets
        redProgressBar.progressLabelInsets = labelInsets
        zeroProgressBar.progressLabelInsets = labelInsets
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

