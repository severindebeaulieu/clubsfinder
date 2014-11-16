//
//  BusinessDetailsViewController.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 16/11/2014.
//  Copyright (c) 2014 Apik56. All rights reserved.
//

import UIKit
import MapKit

class BusinessDetailsViewController: UIViewController, MKMapViewDelegate {
    
    var business: Business!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var businessMap: MKMapView!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = business?.name
        self.businessMap.delegate = self
        
        let annotation = MKPointAnnotation()
        
        // If latitude and longitude are present in the Business, we use them to create the mapview. Else, we use the adress directly
        if ((self.business.latitude != nil) && (self.business.longitude != nil)) {
            let coordinate = CLLocationCoordinate2D(latitude: self.business.latitude!, longitude: self.business.longitude!)
            annotation.setCoordinate(coordinate)
            self.businessMap.addAnnotation(annotation)
            self.businessMap.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(0.01, 0.01)), animated: false)
        } else {
            
            var geocoder = CLGeocoder()
            println(business.streetAddress)
            geocoder.geocodeAddressString(business.streetAddress, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
                if let placemark = placemarks?[0] as? CLPlacemark {
                    let mkp = MKPlacemark(placemark: placemark)
                    self.businessMap.addAnnotation(mkp)
                    annotation.setCoordinate(mkp.coordinate)
                    self.businessMap.addAnnotation(annotation)
                    self.businessMap.setRegion(MKCoordinateRegion(center: mkp.coordinate, span: MKCoordinateSpanMake(0.01, 0.01)), animated: false)
                }
            })
        }
        
        self.businessMap.layer.cornerRadius = 9.0
        self.businessMap.layer.masksToBounds = true
    }
}