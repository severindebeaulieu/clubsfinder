//
//  Album.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 30/10/2014.
//  Copyright (c) 2014. All rights reserved.
//

import Foundation
import CoreLocation


class Business {
    var yelp_id: String
    var is_closed: Bool
    var name: String
    var url: String
    var phone: String
    var location: NSDictionary
    var thumbnailImageURL: String
    var display_phone: String
    
    
    init(yelp_id: String, is_closed: Bool, name: String, url: String, phone: String, location: NSDictionary, thumbnailImageURL: String, display_phone: String) {
        self.yelp_id = yelp_id
        self.is_closed = is_closed
        self.name = name
        self.url = url
        self.phone = phone
        self.location = location
        self.thumbnailImageURL = thumbnailImageURL
        self.display_phone = display_phone
    }
    
    class func businessesWithJSON(allResults: NSArray) -> [Business] {
        
        // Create an empty array of Businesses to append to from this list
        var businesses = [Business]()
        
        // Store the results in our table data array
        if allResults.count>0 {
            
            for result in allResults {
                
                var yelp_id = result["id"] as? String
                var is_closed = result["is_closed"] as? Bool ?? false
                var name = result["name"] as? String ?? ""
                var url = result["url"] as? String ?? ""
                var phone = result["phone"] as? String ?? ""
                var location = result["location"] as? Dictionary<String, AnyObject>
                var thumbnailImageURL = result["image_url"] as? String ?? ""
                var display_phone = result["display_phone"] as? String ?? ""
//                println(location)
//                println("\(yelp_id), \(is_closed), \(name), \(url), \(phone), \(location), \(thumbnailImageURL), ")
                var newBusiness = Business(yelp_id: yelp_id!, is_closed: is_closed, name: name, url: url, phone: phone, location: location!, thumbnailImageURL: thumbnailImageURL, display_phone: display_phone)
                businesses.append(newBusiness)
            }
        }
        return businesses
    }
    
    var shortAddress: String {
        get {
            if let address = location["address"] as? Array<String> {
                if let neighborhoods = location["neighborhoods"] as? Array<String> {
                    return ", ".join(address + [neighborhoods[0]])
                }
                return ", ".join(address)
            }
            return ""
        }
    }
    
    var streetAddress: String {
        get {
            if let address = location["address"] as? Array<String> {
                if let postcode = location["postal_code"] as? String {
                    return ", ".join(address) + ", \(postcode)"
                }
                return ", ".join(address)
            }
            return ""
        }
    }
    
    var latitude: Double? {
        get {

            if let coordinate = location["coordinate"] as? NSDictionary {
                return (coordinate["latitude"] as Double)
            }

            return nil
        }
    }
    
    var longitude: Double? {
        get {
            
            if let coordinate = location["coordinate"] as? NSDictionary {
                return (coordinate["longitude"] as Double)
            }
            
            return nil
        }
    }
    
    var mapLocation: CLLocation {
        get {
            return CLLocation(latitude: self.latitude!, longitude: self.longitude!)
        }
    }
}

