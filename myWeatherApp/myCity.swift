//
//  myCity.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/19/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import UIKit

import UIKit

class myCity: UICollectionViewCell {
    
    @IBOutlet weak var city_name: UILabel!
    
    func displayContent(title: String) {
        city_name.text = title
    }
}
