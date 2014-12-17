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
    
    func yelpClubsIn(town: String, optionalParams: Dictionary<String, String>, offset: Int, limit: Int) {
        var parameters =  ["term": "Dance Clubs", "location": town, "offset": "\(offset)", "limit": "\(limit)"].join(optionalParams)
        self.client.get("http://api.yelp.com/v2/search", parameters: parameters, success: {
            data, response in
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) as String
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            //Array of businesses resutlts
            var businesses = jsonResult["businesses"] as NSMutableArray
            
            //If results, we call the delegate to print
            if (businesses.count > 0) {
                println(businesses)
                self.delegate.didReceiveAPIResults(businesses)
            }
            },
            failure: {
                error in
                println("ERROR : \(error.description)")
        })
        
    }
    
    
    
}