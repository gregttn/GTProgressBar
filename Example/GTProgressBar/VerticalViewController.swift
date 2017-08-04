//
//  VerticalViewController.swift
//  GTProgressBar
//
//  Created by Grzegorz Tatarzyn on 04/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import GTProgressBar

class VerticalViewController: UIViewController {
    @IBOutlet weak var progressBar: GTProgressBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.progressBar.font = UIFont.boldSystemFont(ofSize: 18)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func animateProgressBar(_ sender: Any) {
        let newProgress: CGFloat = progressBar.progress == 0.8 ? 0.1 : 0.8
        progressBar.animateTo(progress: newProgress)
    }
}
