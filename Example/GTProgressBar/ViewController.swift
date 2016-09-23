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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        progressBar.progress = 0.5
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

