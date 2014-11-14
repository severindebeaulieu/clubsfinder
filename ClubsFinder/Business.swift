//
//  Album.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 30/10/2014.
//  Copyright (c) 2014. All rights reserved.
//

import Foundation


class Business {
    var yelp_id: String
    var is_closed: Bool
    var name: String
    var url: String
    var phone: String
    var location: Dictionary<String, AnyObject>
    var thumbnailImageURL: String
    
    
    init(yelp_id: String, is_closed: Bool, name: String, url: String, phone: String, location: Dictionary<String, AnyObject>, thumbnailImageURL: String) {
        self.yelp_id = yelp_id
        self.is_closed = is_closed
        self.name = name
        self.url = url
        self.phone = phone
        self.location = location
        self.thumbnailImageURL = thumbnailImageURL
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
//                println("\(yelp_id), \(is_closed), \(name), \(url), \(phone), \(location), \(thumbnailImageURL), ")
                var newBusiness = Business(yelp_id: yelp_id!, is_closed: is_closed, name: name, url: url, phone: phone, location: location!, thumbnailImageURL: thumbnailImageURL)
                businesses.append(newBusiness)
            }
        }
        return businesses
    }
}

