//
//  ViewController.swift
//  Demo
//
//  Created by Baocheng on 2022/10/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = Float(progressView.circleProgressRatio)
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        progressView.circleProgressRatio = CGFloat(sender.value)
    }
    
}

