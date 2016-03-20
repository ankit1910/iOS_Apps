//
//  ViewController.swift
//  FunFacts
//
//  Created by Ankit on 16/03/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let factBook = FactBook()
    let backgroundColor = ColorWheel()

    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var showFactButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        funFactLabel.text = factBook.randomFact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showFunFact() {
        let color = backgroundColor.randomColor()
        view.backgroundColor = color
        showFactButton.tintColor = color
        funFactLabel.text = factBook.randomFact()
    }
}

