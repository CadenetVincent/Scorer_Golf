//
//  Annotations.swift
//  Project_IOS
//
//  Created by pascal launay on 11/03/2018.
//  Copyright © 2018 pascal launay. All rights reserved.
//

import UIKit
import MapKit
class Annotations: NSObject, MKAnnotation {
  
        var title: String?
        var coordinate: CLLocationCoordinate2D
        var info: String
        
        init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
            self.title = title
            self.coordinate = coordinate
            self.info = info
        }
    
}
