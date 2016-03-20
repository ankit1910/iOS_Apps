//
//  ViewController.swift
//  Stromy
//
//  Created by Ankit on 17/03/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    private let apiKey = "a18b8df6352d30ea103ae5db75a0019f"
    
    var locationManager: CLLocationManager = CLLocationManager()
    var locationString: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshActivityIndicator.hidden = true

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("hello")
        let latestLocation = locations.last!
        
        self.locationString = "\(latestLocation.coordinate.latitude),\(latestLocation.coordinate.longitude)"
        print(locationString!)
        getCurrentWeatherData(self.locationString!)
        manager.stopUpdatingLocation()
    }
    
    
    func getCurrentWeatherData(location: String) -> Void {
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let foreCastURL = NSURL(string: location, relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(foreCastURL!,
            completionHandler: { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
                
                if (error == nil) {
                    let dataObject = NSData(contentsOfURL: location!)
                    let weatherDictionary = try? NSJSONSerialization.JSONObjectWithData(dataObject!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    let currentWeather = Current(weatherDictionary: weatherDictionary!)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.temperatureLabel.text = "\(currentWeather.temperature)"
                        self.iconView.image = currentWeather.icon!
                        self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                        self.humidityLabel.text = "\(currentWeather.humidity)"
                        self.precipitationLabel.text = "\(currentWeather.precipProbability)"
                        self.summaryLabel.text = "\(currentWeather.summary)"
                        
                        //Stop refresing animation
                        self.refreshActivityIndicator.stopAnimating()
                        self.refreshActivityIndicator.hidden = true
                        self.refreshButton.hidden = false
                    })
                } else {
                    let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data, Conectivity Failed", preferredStyle: .Alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    networkIssueController.addAction(okButton)
                    
                    let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                    networkIssueController.addAction(cancelButton)
                    
                    self.presentViewController(networkIssueController, animated: true, completion: nil)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //Stop refresing animation
                        self.refreshActivityIndicator.stopAnimating()
                        self.refreshActivityIndicator.hidden = true
                        self.refreshButton.hidden = false
                    })

                }
        })
        downloadTask.resume()
    }
    

    @IBAction func refresh() {
        getCurrentWeatherData(self.locationString!)
        refreshButton.hidden = true
        refreshActivityIndicator.hidden = false
        refreshActivityIndicator.startAnimating()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

