//
//  ResultatsController.swift
//  Project_IOS
//
//  Created by pascal launay on 11/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit
import MapKit

class ResultatsController: UIViewController {
    
    @IBOutlet var resimg: UIImageView!
    @IBOutlet var MapView: MKMapView!
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resimg.image = UIImage(named:"resgolf.png")
        
        MapView.mapType = MKMapType.standard
        let london = Annotations(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Annotations(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Annotations(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Annotations(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Annotations(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        MapView.addAnnotations([london, oslo, paris, rome, washington])

        // Do any additional setup after loading the view.
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
