//
//  DetailsViewController.swift
//  MusicPlayer
//
//  Created by Séverin de Beaulieu on 30/10/2014.
//  Copyright (c) 2014. All rights reserved.
//

import UIKit
import MediaPlayer
import QuartzCore

class DetailsViewController: UIViewController, APIControllerProtocol {
    lazy var api : APIController = APIController(delegate: self)
    
    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    
//    var album: Album?
//    var tracks = [Track]()
//    var mediaPlayer: MPMoviePlayerController = MPMoviePlayerController()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: APIControllerProtocol
    func didReceiveAPIResults(results: NSDictionary) {
//        var resultsArr: NSArray = results["results"] as NSArray
//        dispatch_async(dispatch_get_main_queue(), {
//            self.tracks = Track.tracksWithJSON(resultsArr)
//            self.tracksTableView.reloadData()
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//        })
    }
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        titleLabel.text = self.album?.title
//        albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.album!.largeImageURL)!)!)
//        // Load in tracks
//        if self.album != nil {
//            api.lookupAlbum(self.album!.collectionId)
//        }
    }
    
    // Animation
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tracks.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell") as TrackCell
//        let track = tracks[indexPath.row]
//        cell.titleLabel.text = track.title
//        cell.playIcon.text = "▶️"
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var track = tracks[indexPath.row]
//        mediaPlayer.stop()
//        mediaPlayer.contentURL = NSURL(string: track.previewUrl)
//        mediaPlayer.play()
//        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? TrackCell {
//            cell.playIcon.text = "◾️"
//        }
//    }
}

