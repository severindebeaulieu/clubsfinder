//
//  SearchResultsViewController.swift
//  MusicPlayer
//
//  Created by Séverin de Beaulieu on 30/10/2014.
//  Copyright (c) 2014. All rights reserved.
//

import UIKit
import QuartzCore

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    
    @IBOutlet var appsTableView : UITableView?
    var businesses = [Business]()
    var api : APIController?
    var imageCache = [String : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = APIController(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api!.yelpClubsIn("Morbihan")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Animation
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        UIView.animateWithDuration(0.25, animations: {
//            cell.layer.transform = CATransform3DMakeScale(1,1,1)
//        })
//    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        println(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultsCell") as SearchResultsCell
        
        let business = self.businesses[indexPath.row]
        
        cell.label1.text = business.name.capitalizedString
//        println(business.location["address"])
        
        cell.label2.text = business.shortAddress
        cell.label3.text = business.phone
        
        cell.imageClub.layer.cornerRadius = 8;
        cell.imageClub.layer.borderWidth = 2;
        
        cell.imageClub.clipsToBounds = true;

        cell.imageClub.image = UIImage(named: "Blank70")
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        let urlString = business.thumbnailImageURL
        
        //Si on a une photo pour le business
        if (urlString != "") {
        
            // Vérifier si notre cache d'images contient la clef. La structure est simplement un dictionnaire d'UIImages.
            //var image: UIImage? = self.imageCache.valueForKey(urlString) as? UIImage
            var image = self.imageCache[urlString]
            
            if( image == nil ) {
                // Si l'image n'existe pas, nous devons la télécharger.
                var imgURL: NSURL? = NSURL(string: urlString)
                
                // Télécharger un NSData contenant l'image de l'URL.
                let request: NSURLRequest = NSURLRequest(URL: imgURL!)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                    if error == nil {
                        image = UIImage(data: data)
                        
                        // Stocker l'image dans notre cache.
                        self.imageCache[urlString] = image
                        dispatch_async(dispatch_get_main_queue(), {
                            cell.imageClub.image = image
                        })
                    }
                    else {
                        println("Error: \(error.localizedDescription)")
                    }
                })
                
            }
            else {
                dispatch_async(dispatch_get_main_queue(), {
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) as? SearchResultsCell {
                        cellToUpdate.imageClub.image = image
                    }
                })
            }
            
        }
        
        return cell
        
    }
    
    
    // The APIControllerProtocol method
    func didReceiveAPIResults(results: NSMutableArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.businesses = Business.businessesWithJSON(results)
            self.appsTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController is BusinessDetailsViewController) {
            var bDetailsViewController: BusinessDetailsViewController = segue.destinationViewController as BusinessDetailsViewController
            var businessIndex = appsTableView!.indexPathForSelectedRow()!.row
            var selectedBusiness = self.businesses[businessIndex]
            bDetailsViewController.business = selectedBusiness
        } else {
            println(segue.destinationViewController)
        }
    }
    

}

