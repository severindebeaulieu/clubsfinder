//
//  FullMapViewController.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 19/12/2014.
//  Copyright (c) 2014 Apik56. All rights reserved.
//

import MapKit

class FullMapViewController: UIViewController {
    
    var business: Business!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = business?.name.capitalizedString
        
        let annotation = MKPointAnnotation()
        
        // If latitude and longitude are present in the Business, we use them to create the mapview. Else, we use the adress directly
        if ((self.business.latitude != nil) && (self.business.longitude != nil)) {
            let coordinate = CLLocationCoordinate2D(latitude: self.business.latitude!, longitude: self.business.longitude!)
            annotation.setCoordinate(coordinate)
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(0.01, 0.01)), animated: false)
        } else {
            
            var geocoder = CLGeocoder()
            println(business.streetAddress)
            geocoder.geocodeAddressString(business.streetAddress, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
                if let placemark = placemarks?[0] as? CLPlacemark {
                    let mkp = MKPlacemark(placemark: placemark)
                    self.mapView.addAnnotation(mkp)
                    annotation.setCoordinate(mkp.coordinate)
                    self.mapView.addAnnotation(annotation)
                    self.mapView.setRegion(MKCoordinateRegion(center: mkp.coordinate, span: MKCoordinateSpanMake(0.01, 0.01)), animated: false)
                }
            })
        }
    }
}