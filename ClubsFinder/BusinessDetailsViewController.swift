//
//  BusinessDetailsViewController.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 16/11/2014.
//  Copyright (c) 2014 Apik56. All rights reserved.
//

import UIKit
import MapKit

class BusinessDetailsViewController: UIViewController {
    
    var business: Business!
    
    let kCellIdentifier: String = "BarsCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var businessMap: MKMapView!
    @IBOutlet weak var barsTab: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = business?.name.capitalizedString
        
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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        switch(indexPath.row) {
        case 0:
            cell.textLabel?.text = "✉️    \(business.streetAddress)"
        case 1:
            cell.textLabel?.text = "🚘    Itinéraire"
        case 2:
            var displayPhone = (business.display_phone != "") ? business.display_phone : business.phone
            cell.textLabel?.text = "📞    \(displayPhone)"
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Get the row data for the selected row
        
        switch(indexPath.row) {
        case 0:
            return
        case 1:
            UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/?saddr=Current+Location&daddr=\(business.streetAddress.urlEncodedStringWithEncoding(NSUTF8StringEncoding))")!)
        case 2:
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(business.phone)")!)
        default:
            return
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController is FullMapViewController) {
            var bDetailsViewController: FullMapViewController = segue.destinationViewController as FullMapViewController
            bDetailsViewController.business = self.business
        }
    }
    
}