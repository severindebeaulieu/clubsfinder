//
//  FiltersViewController.swift
//  ClubsFinder
//
//  Created by Séverin de Beaulieu on 30/11/2014.
//  Copyright (c) 2014 Apik56. All rights reserved.
//

import UIKit

class FiltersViewController: UITableViewController {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}