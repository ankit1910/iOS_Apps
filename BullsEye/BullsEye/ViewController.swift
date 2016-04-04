//
//  ViewController.swift
//  BullsEye
//
//  Created by Ankit on 29/03/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var round = 1
    var totalScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var score: UILabel!

    @IBAction func showAlert() {
        
        self.score.text = String(currentValue)
        
        
        
        let alert = UIAlertController(title: "hello", message: self.score.text , preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "ok", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
        startNewRound()

    }

    @IBAction func sliderMoved(sender: UISlider) {
        
        self.currentValue = lroundf(sender.value)
    }
    
    
    func startNewRound() {
        targetValue = Int(arc4random_uniform(101))
        currentValue = lroundf(slider.value)
    }
}

