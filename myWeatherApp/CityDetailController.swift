//
//  CityDetailController.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/19/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import UIKit

class CityDetailController: UIViewController {
    
    var stringPassed:String = ""
    @IBOutlet weak var firstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstLabel.text = stringPassed
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
