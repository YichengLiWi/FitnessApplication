//
//  CityTableViewController.swift
//  cityView
//
//  Created by Ray Fan on 12/18/17.
//  Copyright © 2017 Ray Fan. All rights reserved.
//

import UIKit
import os.log
import GooglePlaces

class CityTableViewController: UITableViewController {
    
    var cities = [CityList]()
    //MARK: Action
    @IBAction func unwindToCityList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? CityViewController, let city = sourceViewController.city{
            
            
            if cities[0].name.uppercased() != city.name.uppercased(){
                //                let newIndexPath = IndexPath (row: 1, section: 0)
                var count = 0;
                for c in cities{
                    if c.name.uppercased() == city.name.uppercased(){
                        cities.remove(at: count)
                        break
                    }
                    count += 1
                }
                
                let firstCity = cities[0]
                cities[0] = city
                cities.append(firstCity)
                tableView.reloadData()
                saveCities()
            }
            
        }
    }
    
    
    
    @IBAction func autocompleteClicked(_ sender: UIBarButtonItem) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    
    //    @IBAction func addCurrentCity(_ sender: UIBarButtonItem) {
    //        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
    //            if let error = error {
    //                print("Pick Place error: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            if let placeLikelihoodList = placeLikelihoodList {
    //                let place = placeLikelihoodList.likelihoods.first?.place
    //                if let place = place {
    //                    self.current = place.name
    //                }
    //            }
    //        })
    //        guard let currentCity = CityList(name: current)else{
    //            fatalError("Unable to instantiate currentCity")
    //        }
    //        cities.append(currentCity)
    //        saveCities()
    //    }
    
    
    //MARK: private methods
    
    private func loadSampleCities(){
        guard let city1 = CityList(name: "San Jose", lat: 1, lon: 1)else {
            fatalError("Unable to instantiate city1")
        }
        
        guard let city2 = CityList(name: "Fremont", lat: 1, lon: 1)else {
            fatalError("Unable to instantiate city2")
        }
        
        guard let city3 = CityList(name: "Cupertino", lat: 1, lon: 1)else {
            fatalError("Unable to instantiate city3")
        }
        
        cities += [city1, city2, city3]
        
    }
    
    private func saveCities(){
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cities, toFile: CityList.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Cities successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save cities...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCities() -> [CityList]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: CityList.ArchiveURL.path) as? [CityList]
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let saveCities = loadCities(){
            cities += saveCities
        }else{
            loadSampleCities()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CityTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityTableViewCell
            else{
                fatalError("The dequeued cell is not an instance of CityTableViewCell. ")
        }
        
        let city = cities[indexPath.row]
        var cityInfo = Cities()
        // Configure the cell...
        cell.nameLabel.text = city.name
        
        
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            cities.remove(at: indexPath.row)
            saveCities()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension CityTableViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        var isDuplicate: Bool = false
        
        for c in cities {
            if c.name.uppercased() == place.name.uppercased() {
                isDuplicate = true
                break
            }
        }
        
        if isDuplicate == false{
            
            let newIndexPath = IndexPath (row: cities.count, section: 0)
            var city : CityList?
            city = CityList(name: place.name, lat: place.coordinate.latitude, lon: place.coordinate.longitude)
            
            cities.append(city!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            saveCities()
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
