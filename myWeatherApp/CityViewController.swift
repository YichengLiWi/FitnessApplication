//
//  ViewController.swift
//  cityView
//
//  Created by Ray Fan on 12/18/17.
//  Copyright © 2017 Ray Fan. All rights reserved.
//

import UIKit
import os.log
import GooglePlaces

class CityViewController: UIViewController, UITextFieldDelegate {
    
    var city: CityList?
    var lat: Double?
    var lon: Double?
    
    //MARK: Properties
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func autocompleteClicked(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = cityNameTextField.text ?? ""
        
        
        city = CityList(name: name, lat: lat!, lon: lon!, temp: 0)
        
    }
    
    //MARK: Action
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        updateSaveButtonState()
//        navigationItem.title = textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cityNameTextField.delegate = self
        updateSaveButtonState()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState(){
        let text = cityNameTextField.text ?? ""
        let latitude = lat ?? -200
        let longitude = lon ?? -200
        
        saveButton.isEnabled = !text.isEmpty && latitude != -200 && longitude != -200
        
    }
    
    
}
extension CityViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        cityNameTextField.text = place.name
        lat = place.coordinate.latitude
        lon = place.coordinate.longitude
        updateSaveButtonState()
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


