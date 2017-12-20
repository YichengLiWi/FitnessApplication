//
//  CityDetailController.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/19/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import UIKit

class CityDetailController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
  
    let cities:[String] = ["San Jose", "San Francisco", "New York", "Los Angeles"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInsert = UIEdgeInsertsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.scrollDirection = .horizontal
        myCollectionView.isPagingEnabled = true
        myCollectionView.collectionViewLayout = layout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //Populate views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "city_cell", for: indexPath) as! myCity
        cell.displayContent(title: cities[indexPath.row])
        print(cities[indexPath.row])
        cell.backgroundColor = .red
        return cell
        
    }
}
