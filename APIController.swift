//
//  APIController.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 30/10/2014.
//  Copyright (c) 2014. All rights reserved.
//
import UIKit

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSMutableArray)
}

class APIController {
    var delegate: APIControllerProtocol
    var client: OAuthSwiftClient
    
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
        self.client = OAuthSwiftClient(consumerKey: "ovEqSgqjunCWISBgLt1cUw", consumerSecret: "uTKwErEH6wub6pAWVG1zQ-V0dTQ", accessToken: "y_PR976w4FQy5i-FeAUEayyTuOnfgf8q", accessTokenSecret: "btEOld55Rg97lLb-diw2IBYmvA0")
    }
    
    //Function to have more than 20 results
    func yelpClubsInLoop(town: String, offset: Int, limit: Int, businesses: NSMutableArray) {
        var businessesTmp: NSArray = []
        var parameters =  ["term": "Dance Clubs", "location": town, "offset": "\(offset)", "limit": "\(limit)"]
        self.client.get("http://api.yelp.com/v2/search", parameters: parameters, success: {
            data, response in
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) as String
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            //Add of 20 businesses to final array
            businessesTmp = jsonResult["businesses"] as NSArray
            businesses.addObjectsFromArray(businessesTmp)
            
            //If still results, we call the API again
            if (businessesTmp.count > 0) {
                var newOffset = offset + limit
                self.yelpClubsInLoop(town, offset: newOffset, limit: limit, businesses: businesses)
            } else {
                //When no more results, we call the delegate to print the array
                self.delegate.didReceiveAPIResults(businesses)
            }
            },
            failure: {
                error in
                println("ERROR : \(error.description)")
        })
    }
    
    
    func yelpClubsIn(town: String) {
        var offset = 0
        var limit = 20
        var businessesTmp: NSMutableArray = NSMutableArray()
        yelpClubsInLoop(town, offset: offset, limit: limit, businesses: businessesTmp)
    }
    
}