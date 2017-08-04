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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
